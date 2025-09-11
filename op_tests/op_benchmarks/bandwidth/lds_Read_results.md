# LDS Read Bandwidth Test Results

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
| ds_read_b64 (64-bit) | 20.00 | 1112.09 |
| ds_read_b64 (64-bit) | 1280.00 | 1347.08 |
| ds_read_b64 (64-bit) | 3200.00 | 1353.89 |
| ds_read_b64 (64-bit) | 6400.00 | 1355.64 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_read_b128 (128-bit) | 20.00 | 2185.27 |
| ds_read_b128 (128-bit) | 1280.00 | 2655.30 |
| ds_read_b128 (128-bit) | 3200.00 | 2686.93 |
| ds_read_b128 (128-bit) | 6400.00 | 2712.63 |

