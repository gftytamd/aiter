# Global Load (Cached) Bandwidth Test Results

## System Information

- **GPU**: 
- **Compute Units**: 80
- **OCCUPANCY_PER_CU**: 16
- **Block Size**: 1024
- **Unroll Factor**: 8



## Results by Vector Width

### 32-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|

### 64-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx2 (64-bit) | 20.00 | 991.53 |
| global_load_dwordx2 (64-bit) | 80.00 | 974.40 |
| global_load_dwordx2 (64-bit) | 100.00 | 1094.71 |
| global_load_dwordx2 (64-bit) | 160.00 | 1040.39 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx4 (128-bit) | 20.00 | 1882.27 |
| global_load_dwordx4 (128-bit) | 80.00 | 1948.99 |
| global_load_dwordx4 (128-bit) | 100.00 | 1954.00 |
| global_load_dwordx4 (128-bit) | 160.00 | 1175.08 |

