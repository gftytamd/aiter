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
| global_load_dwordx2_nt (64-bit) | 20.00 | 3117.41 |
| global_load_dwordx2_nt (64-bit) | 80.00 | 3126.00 |
| global_load_dwordx2_nt (64-bit) | 100.00 | 3153.86 |
| global_load_dwordx2_nt (64-bit) | 160.00 | 3165.98 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx4_nt (128-bit) | 20.00 | 3732.60 |
| global_load_dwordx4_nt (128-bit) | 80.00 | 3721.80 |
| global_load_dwordx4_nt (128-bit) | 100.00 | 3740.16 |
| global_load_dwordx4_nt (128-bit) | 160.00 | 3716.33 |

