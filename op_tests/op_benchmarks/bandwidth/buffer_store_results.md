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
| buffer_store_dwordx2 (64-bit) | 20.00 | 2194.70 |
| buffer_store_dwordx2 (64-bit) | 80.00 | 2188.45 |
| buffer_store_dwordx2 (64-bit) | 100.00 | 2237.38 |
| buffer_store_dwordx2 (64-bit) | 160.00 | 2237.97 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| buffer_store_dwordx4 (128-bit) | 20.00 | 1394.74 |
| buffer_store_dwordx4 (128-bit) | 80.00 | 1393.28 |
| buffer_store_dwordx4 (128-bit) | 100.00 | 1394.12 |
| buffer_store_dwordx4 (128-bit) | 160.00 | 1394.36 |

