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
| global_load_dwordx2_nt (64-bit) | 20.00 | 894.41 |
| global_load_dwordx2_nt (64-bit) | 80.00 | 894.96 |
| global_load_dwordx2_nt (64-bit) | 100.00 | 992.30 |
| global_load_dwordx2_nt (64-bit) | 160.00 | 991.79 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx4_nt (128-bit) | 20.00 | 1643.15 |
| global_load_dwordx4_nt (128-bit) | 80.00 | 1652.03 |
| global_load_dwordx4_nt (128-bit) | 100.00 | 1650.20 |
| global_load_dwordx4_nt (128-bit) | 160.00 | 1651.78 |

