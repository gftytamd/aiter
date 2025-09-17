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
| buffer_store_dwordx2 (64-bit) | 20.00 | 2190.62 |
| buffer_store_dwordx2 (64-bit) | 80.00 | 2192.24 |
| buffer_store_dwordx2 (64-bit) | 100.00 | 2245.11 |
| buffer_store_dwordx2 (64-bit) | 160.00 | 2245.94 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| buffer_store_dwordx4 (128-bit) | 20.00 | 1392.71 |
| buffer_store_dwordx4 (128-bit) | 80.00 | 1390.69 |
| buffer_store_dwordx4 (128-bit) | 100.00 | 1393.05 |
| buffer_store_dwordx4 (128-bit) | 160.00 | 1393.59 |

