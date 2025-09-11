# LDS Write Bandwidth Test Results

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
| ds_write_b64 (64-bit) | 20.00 | 6339.42 |
| ds_write_b64 (64-bit) | 1280.00 | 9311.81 |
| ds_write_b64 (64-bit) | 3200.00 | 9479.55 |
| ds_write_b64 (64-bit) | 6400.00 | 9539.35 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_write_b128 (128-bit) | 20.00 | 7257.81 |
| ds_write_b128 (128-bit) | 1280.00 | 9256.66 |
| ds_write_b128 (128-bit) | 3200.00 | 9471.62 |
| ds_write_b128 (128-bit) | 6400.00 | 9542.93 |

