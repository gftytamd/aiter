# Global Load Non-Temporal Bandwidth Test Results

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
| global_load_dwordx2_nt (64-bit) | 20.00 | 3099.30 |
| global_load_dwordx2_nt (64-bit) | 80.00 | 3105.73 |
| global_load_dwordx2_nt (64-bit) | 100.00 | 3166.86 |
| global_load_dwordx2_nt (64-bit) | 160.00 | 3168.25 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx4_nt (128-bit) | 20.00 | 3868.59 |
| global_load_dwordx4_nt (128-bit) | 80.00 | 3877.42 |
| global_load_dwordx4_nt (128-bit) | 100.00 | 3880.29 |
| global_load_dwordx4_nt (128-bit) | 160.00 | 3873.48 |

