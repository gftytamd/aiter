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
| global_store_dwordx2_nt (64-bit) | 20.00 | 2231.19 |
| global_store_dwordx2_nt (64-bit) | 80.00 | 2225.20 |
| global_store_dwordx2_nt (64-bit) | 100.00 | 2258.04 |
| global_store_dwordx2_nt (64-bit) | 160.00 | 2264.54 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_store_dwordx4_nt (128-bit) | 20.00 | 1394.14 |
| global_store_dwordx4_nt (128-bit) | 80.00 | 1394.63 |
| global_store_dwordx4_nt (128-bit) | 100.00 | 1396.32 |
| global_store_dwordx4_nt (128-bit) | 160.00 | 1394.46 |

