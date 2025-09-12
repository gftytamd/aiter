# Buffer Load Bandwidth Test Results

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
| buffer_load_dwordx2 (64-bit) | 20.00 | 1744.13 |
| buffer_load_dwordx2 (64-bit) | 80.00 | 1744.04 |
| buffer_load_dwordx2 (64-bit) | 100.00 | 1773.78 |
| buffer_load_dwordx2 (64-bit) | 160.00 | 1774.02 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| buffer_load_dwordx4 (128-bit) | 20.00 | 1779.33 |
| buffer_load_dwordx4 (128-bit) | 80.00 | 1779.08 |
| buffer_load_dwordx4 (128-bit) | 100.00 | 1779.09 |
| buffer_load_dwordx4 (128-bit) | 160.00 | 1779.39 |

