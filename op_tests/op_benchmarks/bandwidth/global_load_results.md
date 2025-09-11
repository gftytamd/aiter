# Global Load (Cached) Bandwidth Test Results

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
| global_load_dwordx2 (64-bit) | 20.00 | 3258.21 |
| global_load_dwordx2 (64-bit) | 80.00 | 3300.31 |
| global_load_dwordx2 (64-bit) | 100.00 | 3393.00 |
| global_load_dwordx2 (64-bit) | 160.00 | 3393.88 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| global_load_dwordx4 (128-bit) | 20.00 | 4813.34 |
| global_load_dwordx4 (128-bit) | 80.00 | 4813.17 |
| global_load_dwordx4 (128-bit) | 100.00 | 4792.11 |
| global_load_dwordx4 (128-bit) | 160.00 | 4801.98 |

