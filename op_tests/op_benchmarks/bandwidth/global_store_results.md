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
| global_store_dwordx2 (64-bit) | 20.00 | 2198.59 |
| global_store_dwordx2 (64-bit) | 80.00 | 2200.64 |
| global_store_dwordx2 (64-bit) | 100.00 | 2244.94 |
| global_store_dwordx2 (64-bit) | 160.00 | 2246.31 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_store_dwordx4 (128-bit) | 20.00 | 1388.10 |
| global_store_dwordx4 (128-bit) | 80.00 | 1389.03 |
| global_store_dwordx4 (128-bit) | 100.00 | 1390.76 |
| global_store_dwordx4 (128-bit) | 160.00 | 1389.15 |

