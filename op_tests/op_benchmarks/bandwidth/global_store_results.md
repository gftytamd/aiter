# Global Store Bandwidth Test Results

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
| global_store_dwordx2 (64-bit) | 20.00 | 2196.54 |
| global_store_dwordx2 (64-bit) | 80.00 | 2196.58 |
| global_store_dwordx2 (64-bit) | 100.00 | 2246.41 |
| global_store_dwordx2 (64-bit) | 160.00 | 2246.67 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_store_dwordx4 (128-bit) | 20.00 | 1390.49 |
| global_store_dwordx4 (128-bit) | 80.00 | 1390.79 |
| global_store_dwordx4 (128-bit) | 100.00 | 1390.59 |
| global_store_dwordx4 (128-bit) | 160.00 | 1389.07 |

