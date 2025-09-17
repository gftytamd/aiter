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
| buffer_load_dwordx2 (64-bit) | 20.00 | 1743.59 |
| buffer_load_dwordx2 (64-bit) | 80.00 | 1743.81 |
| buffer_load_dwordx2 (64-bit) | 100.00 | 1773.50 |
| buffer_load_dwordx2 (64-bit) | 160.00 | 1772.16 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| buffer_load_dwordx4 (128-bit) | 20.00 | 1778.72 |
| buffer_load_dwordx4 (128-bit) | 80.00 | 1778.69 |
| buffer_load_dwordx4 (128-bit) | 100.00 | 1777.95 |
| buffer_load_dwordx4 (128-bit) | 160.00 | 1777.24 |

