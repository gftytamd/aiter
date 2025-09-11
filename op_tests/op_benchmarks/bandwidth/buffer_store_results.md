# Buffer Store Bandwidth Test Results

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
| buffer_store_dwordx2 (64-bit) | 20.00 | 2194.88 |
| buffer_store_dwordx2 (64-bit) | 80.00 | 2184.48 |
| buffer_store_dwordx2 (64-bit) | 100.00 | 2243.71 |
| buffer_store_dwordx2 (64-bit) | 160.00 | 2248.34 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| buffer_store_dwordx4 (128-bit) | 20.00 | 1392.10 |
| buffer_store_dwordx4 (128-bit) | 80.00 | 1350.10 |
| buffer_store_dwordx4 (128-bit) | 100.00 | 1392.75 |
| buffer_store_dwordx4 (128-bit) | 160.00 | 1392.05 |

