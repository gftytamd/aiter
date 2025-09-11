# Global Store Non-Temporal Bandwidth Test Results

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
| global_store_dwordx2_nt (64-bit) | 20.00 | 2224.61 |
| global_store_dwordx2_nt (64-bit) | 80.00 | 2216.97 |
| global_store_dwordx2_nt (64-bit) | 100.00 | 2247.65 |
| global_store_dwordx2_nt (64-bit) | 160.00 | 2248.73 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_store_dwordx4_nt (128-bit) | 20.00 | 1397.30 |
| global_store_dwordx4_nt (128-bit) | 80.00 | 1397.44 |
| global_store_dwordx4_nt (128-bit) | 100.00 | 1397.24 |
| global_store_dwordx4_nt (128-bit) | 160.00 | 1395.92 |

