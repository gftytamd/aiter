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
| global_store_dwordx2_nt (64-bit) | 20.00 | 2225.61 |
| global_store_dwordx2_nt (64-bit) | 80.00 | 2232.45 |
| global_store_dwordx2_nt (64-bit) | 100.00 | 2263.06 |
| global_store_dwordx2_nt (64-bit) | 160.00 | 2259.83 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_store_dwordx4_nt (128-bit) | 20.00 | 1395.57 |
| global_store_dwordx4_nt (128-bit) | 80.00 | 1396.54 |
| global_store_dwordx4_nt (128-bit) | 100.00 | 1394.44 |
| global_store_dwordx4_nt (128-bit) | 160.00 | 945.48 |

