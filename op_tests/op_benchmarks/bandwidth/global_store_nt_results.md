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
| global_store_dwordx2_nt (64-bit) | 20.00 | 2227.66 |
| global_store_dwordx2_nt (64-bit) | 80.00 | 2232.09 |
| global_store_dwordx2_nt (64-bit) | 100.00 | 2260.18 |
| global_store_dwordx2_nt (64-bit) | 160.00 | 2263.21 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_store_dwordx4_nt (128-bit) | 20.00 | 1394.55 |
| global_store_dwordx4_nt (128-bit) | 80.00 | 1394.91 |
| global_store_dwordx4_nt (128-bit) | 100.00 | 1395.56 |
| global_store_dwordx4_nt (128-bit) | 160.00 | 1395.82 |

