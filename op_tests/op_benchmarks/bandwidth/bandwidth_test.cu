// SPDX-License-Identifier: MIT
// Copyright (C) 2018-2025, Advanced Micro Devices, Inc. All rights reserved.

#include "kernels.h"

template <typename T, HFMemOp Op>
BenchmarkResult run_benchmark_return_result(const std::string& test_name, int num_cu, int64_t data_size_dwords)
{
    BenchmarkResult result;
    result.operation = test_name;
    
    if (std::is_same_v<T, float>) {
        result.vector_width = "32-bit";
    } else if (std::is_same_v<T, float2>) {
        result.vector_width = "64-bit";
    } else if (std::is_same_v<T, float4>) {
        result.vector_width = "128-bit";
    }

    // only test with dsum trigger hsum and dsum comp
    bool compare_sum = (Op == HFMemOp::GlobalLoad) || (Op == HFMemOp::GlobalLoadNT) || (Op == HFMemOp::BufferLoad) || (Op == HFMemOp::DsRead);
    
    result.size_mb = data_size_dwords * sizeof(float) / (1024.0 * 1024.0);
    
    const int grid_size = num_cu * OCCUPANCY_PER_CU;
    const int block_size = BLOCK_SIZE;

    const size_t num_elements_total = data_size_dwords / (sizeof(T) / sizeof(float));


    const size_t num_elements_per_block = (num_elements_total + grid_size - 1) / grid_size;
    const int iters = (num_elements_per_block + (block_size * UNROLL_FACTOR) - 1) / (block_size * UNROLL_FACTOR);
    // std::cout << "iters: " << iters << std::endl;
    const size_t num_elements_aligned = (size_t)grid_size * iters * block_size * UNROLL_FACTOR;
    const size_t data_size_bytes = num_elements_aligned * sizeof(T);
    const size_t data_per_block = block_size * iters * UNROLL_FACTOR;
    const size_t num_refdata = (size_t)grid_size * block_size;
    const size_t refdata_size_bytes = num_refdata * sizeof(float); // reference data for each thread
    const size_t stride_per_element = (sizeof(T) / sizeof(float));

    T* d_data = nullptr;
    // host data generator
    // std::vector<float> h_data(num_elements_aligned * stride_per_element, 1.0);
    // for (int i = 0; i < h_data.size(); ++i){
    //     size_t block_id = i / (iters * block_size * UNROLL_FACTOR * stride_per_element);
    //     h_data[i] = ( i % (block_size * stride_per_element) + 1) * (block_id+1);
    // }
    // upper bound index: 1024*2*8*1279+2048*8-1
    // std::cout << "hdata: " << h_data[2048*8*1279+2046] << ", " << h_data[2048*8*1279+2048*8-1] << std::endl;
    std::vector<float> h_data(data_size_bytes, 1.0);
    if (compare_sum) {
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_real_distribution<float> dist(0.0, 3.0);
        std::generate(h_data.begin(), h_data.end(), [&](){return dist(gen);});
    }
    else {
        const float ref_array[4] = {1.23f, 2.34f, 3.45f, 4.56f};
        for (int i = 0; i < h_data.size(); ++i) {
            h_data[i] = ref_array [i % stride_per_element];
        }
    }
    std::cout << "test info: " << h_data.size() << " " << num_elements_aligned << " " << data_size_bytes << std::endl;
    // host sum generator
    std::vector<float> h_sum(num_refdata, 0.0);
    if (compare_sum) {
        for (int i = 0; i < num_refdata; ++i) {
            size_t block_id = i / block_size;
            size_t thread_id = i % block_size;
            const size_t block_base_offt = block_id * data_per_block * stride_per_element;
            float local_sum = 0.0f;
            for (int j = 0; j < iters; ++j) {
                size_t offs = UNROLL_FACTOR * block_size * j * stride_per_element + thread_id * stride_per_element;
                for (int k = 0; k < UNROLL_FACTOR; ++k) {
                    size_t cur_offt = block_base_offt + offs;
                    for (int l = 0; l < stride_per_element; ++l) {
                        local_sum += h_data[cur_offt+l];
                    }
                    offs += block_size * stride_per_element;
                }
            }
            h_sum[i] = local_sum;
        }
    }
    // for (int i = 0; i < grid_size; ++i) {
    //     // block data offt
    //     size_t block_offt = i * data_per_block * stride_per_element;
    //     // host sum idx
    //     size_t h_sum_base_offt = i * block_size;
    //     // current vector begin iterator for block
    //     auto block_start = h_data.begin() + block_offt;
    //     auto block_end = std::min(block_start + data_per_block * stride_per_element, h_data.end());
    //     for (int j = 0; j < block_size; ++j) {
    //         // current thread begin iterator
    //         auto thread_start = block_start + j * stride_per_element;
    //         float thread_sum = 0.0;
    //         size_t cur_h_sum_id = h_sum_base_offt + j;
    //         for (auto it = thread_start; it < block_end; it += block_size * stride_per_element){
    //             for (auto s = 0; s < stride_per_element; ++s) {
    //                 thread_sum += *(it+s);
    //             }
    //         }
    //         h_sum[cur_h_sum_id] = thread_sum;
    //     }
    // }

    float* d_sum = nullptr;
    HIP_CHECK(hipMalloc(&d_data, data_size_bytes));
    HIP_CHECK(hipMemcpyHtoD(d_data, static_cast<void*>(h_data.data()), data_size_bytes));
    HIP_CHECK(hipMalloc(&d_sum, refdata_size_bytes));
    // HIP_CHECK(hipMemcpyHtoD(d_sum, static_cast<void*>(h_sum.data()), refdata_size_bytes));
    HIP_CHECK(hipMemset(d_sum, 0, refdata_size_bytes));

    hipEvent_t start, stop;
    HIP_CHECK(hipEventCreate(&start));
    HIP_CHECK(hipEventCreate(&stop));

    dim3 grid(grid_size, 1, 1);
    dim3 block(block_size, 1, 1);

    // warm up
    for(int i = 0; i < 0; i++){
        if constexpr (Op == HFMemOp::GlobalLoad) {
            global_load_kernel<T><<<grid, block>>>(d_data, data_per_block, iters, d_sum);
        } else if constexpr (Op == HFMemOp::GlobalLoadNT) {
            global_load_nt_kernel<T><<<grid, block>>>(d_data, data_per_block, iters, d_sum);
        } else if constexpr (Op == HFMemOp::GlobalStore) {
            global_store_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::GlobalStoreNT) {
            global_store_nt_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::BufferStore) {
            buffer_store_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::BufferLoad) {  
            buffer_load_reg_kernel<T><<<grid, block>>>(d_data, data_per_block, iters, d_sum);
         }else if constexpr (Op == HFMemOp::BufferLoadLDS) {
            buffer_load_lds_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::DsRead) {    
            size_t lds_size_bytes = block_size * UNROLL_FACTOR * sizeof(T);
            lds_load_kernel<T><<<grid, block, lds_size_bytes>>>(d_data,iters, d_sum);
        } else if constexpr (Op == HFMemOp::DsWrite) { 
            size_t lds_size_bytes = block_size * UNROLL_FACTOR * sizeof(T);
            lds_write_kernel<T><<<grid, block, lds_size_bytes>>>(d_data, iters);
        }
    }

    HIP_CHECK(hipEventRecord(start));
    for(int i = 0; i < 1; ++i) {
        if constexpr (Op == HFMemOp::GlobalLoad) {
            global_load_kernel<T><<<grid, block>>>(d_data, data_per_block, iters, d_sum);
        } else if constexpr (Op == HFMemOp::GlobalLoadNT) {
            global_load_nt_kernel<T><<<grid, block>>>(d_data, data_per_block, iters, d_sum);
        } else if constexpr (Op == HFMemOp::GlobalStore) {
            global_store_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::GlobalStoreNT) {
            global_store_nt_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::BufferStore) {
            buffer_store_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::BufferLoad) {  
            buffer_load_reg_kernel<T><<<grid, block>>>(d_data, data_per_block, iters, d_sum);
         }else if constexpr (Op == HFMemOp::BufferLoadLDS) {
            buffer_load_lds_kernel<T><<<grid, block>>>(d_data, data_per_block, iters);
        } else if constexpr (Op == HFMemOp::DsRead) {    
            lds_load_kernel<T><<<grid, block>>>(d_data, iters, d_sum);
        } else if constexpr (Op == HFMemOp::DsWrite) { 
            lds_write_kernel<T><<<grid, block>>>(d_data,  iters);
        }
    }
    HIP_CHECK(hipEventRecord(stop));
    HIP_CHECK(hipEventSynchronize(stop));

    float milliseconds = 0;
    HIP_CHECK(hipEventElapsedTime(&milliseconds, start, stop));
    milliseconds /= LOOP;

    result.bandwidth_gb_s = (data_size_bytes / (1e9)) / (milliseconds / 1000.0);
    printf("%-40s: %.2f GB/s\n", test_name.c_str(), result.bandwidth_gb_s);

    // check invalid -1 d_sum
    if (compare_sum) {
        std::vector<float> dut_sum(num_refdata, -1.0);
        HIP_CHECK(hipMemcpyDtoH(static_cast<void*>(dut_sum.data()), d_sum, refdata_size_bytes));
        size_t wrong_cnt = 0;
        for (int i = 0; i < dut_sum.size(); i++) {
            // std::cout << "No: " << i << ", dut sum " << dut_sum[i] << ", ref sum " << h_sum[i] << std::endl;
            // if (dut_sum[i] != h_sum[i]) {
            if (std::abs(dut_sum[i] - h_sum[i]) > 0.01) {
                // std::cout << "No: " << i << " is 0." << std::endl;
                // std::cout << "No: " << i << " host dut vs ref: " << dut_sum[i] << " " << h_sum[i] << std::endl;
                ++wrong_cnt;
            }
        }
        size_t thread_probe = 1023;
        size_t block_probe = 1279;
        size_t test_probe = block_size * block_probe + thread_probe;
        std::cout << "host dut vs ref: " << dut_sum[test_probe] << " " << h_sum[test_probe] << std::endl;
        std::cout << "data size: " << dut_sum.size() << ", wrong num: " << wrong_cnt << std::endl;
    }
    // check d_data vs h_data
    std::vector<float> dut_data(num_elements_aligned * stride_per_element, 0.0);
    HIP_CHECK(hipMemcpyDtoH(static_cast<void*>(dut_data.data()), d_data, data_size_bytes));
    for (int i = 0; i < dut_data.size(); i++) {
        if(dut_data[i] != h_data[i]) {
            std::cout << "dut != ref at " << i << ", dut = " << dut_data[i] << ", ref = " << h_data[i] << std::endl;
            break;
        }
    }

    HIP_CHECK(hipEventDestroy(start));
    HIP_CHECK(hipEventDestroy(stop));
    HIP_CHECK(hipFree(d_data));
    HIP_CHECK(hipFree(d_sum));
    
    return result;
}


void write_results_to_file(const std::vector<BenchmarkResult>& results, const std::string& filename, 
                          const std::string& title, const hipDeviceProp_t& props, int num_cu) {
    FILE* md_file = fopen(filename.c_str(), "w");
    if (!md_file) {
        printf("Error: Failed to create markdown file %s.\n", filename.c_str());
        return;
    }

    fprintf(md_file, "# %s\n\n", title.c_str());
    fprintf(md_file, "## System Information\n\n");
    fprintf(md_file, "- **GPU**: %s\n", props.name);
    fprintf(md_file, "- **Compute Units**: %d\n", num_cu);
    fprintf(md_file, "- **OCCUPANCY_PER_CU**: %d\n", OCCUPANCY_PER_CU);
    fprintf(md_file, "- **Block Size**: %d\n", BLOCK_SIZE);
    fprintf(md_file, "- **Unroll Factor**: %d\n\n", UNROLL_FACTOR);
    
    fprintf(md_file, "\n\n## Results by Vector Width\n\n");
    
    std::vector<std::string> vector_widths = {"32-bit", "64-bit", "128-bit"};
    
    for (const auto& width : vector_widths) {
        fprintf(md_file, "### %s Operations\n\n", width.c_str());
        fprintf(md_file, "| Operation | Data Size (MB) | Bandwidth (GB/s) |\n");
        fprintf(md_file, "|-----------|---------------:|----------------:|\n");
        
        for (const auto& result : results) {
            if (result.vector_width == width) {
                    fprintf(md_file, "| %s | %.2f | %.2f |\n", 
                            result.operation.c_str(), result.size_mb, result.bandwidth_gb_s);
                
            }
        }
        fprintf(md_file, "\n");
    }
    
    fclose(md_file);
}

std::vector<BenchmarkResult> run_global_load_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Global Load (Cached) Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::GlobalLoad>(
            "global_load_dwordx2 (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::GlobalLoad>(
            "global_load_dwordx4 (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "global_load_results.md", 
                          "Global Load (Cached) Bandwidth Test Results", 
                          /*props=*/{}, num_cu);

    return results;
}

std::vector<BenchmarkResult> run_global_load_nt_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Global Load Non-Temporal Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::GlobalLoadNT>(
            "global_load_dwordx2_nt (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::GlobalLoadNT>(
            "global_load_dwordx4_nt (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "global_load_nt_results.md", 
                          "Global Load Non-Temporal Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

std::vector<BenchmarkResult> run_global_store_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Global Store Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::GlobalStore>(
            "global_store_dwordx2 (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::GlobalStore>(
            "global_store_dwordx4 (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "global_store_results.md", 
                          "Global Store Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

std::vector<BenchmarkResult> run_global_store_nt_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Global Store Non-Temporal Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::GlobalStoreNT>(
            "global_store_dwordx2_nt (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::GlobalStoreNT>(
            "global_store_dwordx4_nt (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "global_store_nt_results.md", 
                          "Global Store Non-Temporal Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

std::vector<BenchmarkResult> run_buffer_store_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Buffer Store Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::BufferStore>(
            "buffer_store_dwordx2 (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::BufferStore>(
            "buffer_store_dwordx4 (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "buffer_store_results.md", 
                          "Buffer Store Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

std::vector<BenchmarkResult> run_buffer_load_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Buffer Load Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::BufferLoad>(
            "buffer_load_dwordx2 (64-bit)", num_cu, dwords));
        // results.push_back(run_benchmark_return_result<float4, HFMemOp::BufferLoad>(
        //     "buffer_load_dwordx4 (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "buffer_load_results.md", 
                          "Buffer Load Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

std::vector<BenchmarkResult> run_buffer_load_lds_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running Buffer Load LDS Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float, HFMemOp::BufferLoadLDS>(
            "buffer_load_dword (32-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "buffer_load_lds_results.md", 
                          "Buffer Load LDS Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}


std::vector<BenchmarkResult> run_lds_read_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running LDS Read Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::DsRead>(
            "ds_read_b64 (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::DsRead>(
            "ds_read_b128 (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "lds_Read_results.md", 
                          "LDS Read Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

std::vector<BenchmarkResult> run_lds_write_test(int num_cu, const std::vector<int64_t>& data_sizes) {
    std::vector<BenchmarkResult> results;
    printf("\n--- Running LDS Write Memory Bandwidth Test ---\n");
    
    for (int64_t dwords : data_sizes) {
        double size_mb = dwords * sizeof(float) / (1024.0 * 1024.0);
        printf("\n--- Testing with data size: %.2f MB ---\n", size_mb);

        results.push_back(run_benchmark_return_result<float2, HFMemOp::DsWrite>(
            "ds_write_b64 (64-bit)", num_cu, dwords));
        results.push_back(run_benchmark_return_result<float4, HFMemOp::DsWrite>(
            "ds_write_b128 (128-bit)", num_cu, dwords));
    }
    
    write_results_to_file(results, "lds_Write_results.md", 
                          "LDS Write Bandwidth Test Results", 
                          /*props=*/{}, num_cu);
    
    return results;
}

void run_all_tests(const std::string& test_name = "") {
    hipDeviceProp_t props;
    HIP_CHECK(hipGetDeviceProperties(&props, 0));
    const int num_cu = props.multiProcessorCount;

    printf("=== GPU Memory Bandwidth Benchmark Suite ===\n");
    printf("GPU: %s, CUs: %d, BlockSize: %d, Unroll: %d, OCCUPANCY_PER_CU: %d\n\n",
           props.name, num_cu, BLOCK_SIZE, UNROLL_FACTOR, OCCUPANCY_PER_CU);

    std::vector<int64_t> data_sizes = {
    static_cast<int64_t>(64) * num_cu * BLOCK_SIZE
    // static_cast<int64_t>(256) * num_cu * BLOCK_SIZE,
    // static_cast<int64_t>(320) * num_cu * BLOCK_SIZE,
    // static_cast<int64_t>(512) * num_cu * BLOCK_SIZE
};

    std::vector<int64_t> lds_data_sizes = {
    static_cast<int64_t>(64) * num_cu * BLOCK_SIZE,
    static_cast<int64_t>(4096) * num_cu * BLOCK_SIZE,
    static_cast<int64_t>(10240) * num_cu * BLOCK_SIZE,
    static_cast<int64_t>(20480) * num_cu * BLOCK_SIZE
};

    if (test_name.empty() || test_name == "global_load") {
        run_global_load_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "global_load_nt") {
        run_global_load_nt_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "global_store") {
        run_global_store_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "global_store_nt") {
        run_global_store_nt_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "buffer_load") {
        run_buffer_load_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "buffer_store") {
        run_buffer_store_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "buffer_load_lds") {
        run_buffer_load_lds_test(num_cu, data_sizes);
    }
    
    if (test_name.empty() || test_name == "lds_read") {
        run_lds_read_test(num_cu, lds_data_sizes);
    }
    
    if (test_name.empty() || test_name == "lds_write") {
        run_lds_write_test(num_cu, lds_data_sizes);
    }

}

int main(int argc, char* argv[]) {
    
    std::vector<std::string> valid_tests = {
            "global_load", "global_load_nt", "global_store", "global_store_nt",
            "buffer_store", "buffer_load", "buffer_load_lds", "lds_read", "lds_write",
            ""
        };
    std::string test_name = "lds_read";
    run_all_tests(test_name);
    return 0;
}
