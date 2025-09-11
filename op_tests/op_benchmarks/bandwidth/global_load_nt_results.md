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
| global_load_dwordx2_nt (64-bit) | 20.00 | 3131.75 |
| global_load_dwordx2_nt (64-bit) | 80.00 | 3119.13 |
| global_load_dwordx2_nt (64-bit) | 100.00 | 3154.86 |
| global_load_dwordx2_nt (64-bit) | 160.00 | 3163.73 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx4_nt (128-bit) | 20.00 | 3767.41 |
| global_load_dwordx4_nt (128-bit) | 80.00 | 3778.30 |
| global_load_dwordx4_nt (128-bit) | 100.00 | 3756.10 |
| global_load_dwordx4_nt (128-bit) | 160.00 | 3779.01 |

