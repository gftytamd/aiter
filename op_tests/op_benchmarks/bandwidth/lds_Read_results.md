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
| ds_read_b64 (64-bit) | 20.00 | 10995.40 |
| ds_read_b64 (64-bit) | 1280.00 | 13991.94 |
| ds_read_b64 (64-bit) | 3200.00 | 14136.03 |
| ds_read_b64 (64-bit) | 6400.00 | 14191.80 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_read_b128 (128-bit) | 20.00 | 12695.38 |
| ds_read_b128 (128-bit) | 1280.00 | 14095.73 |
| ds_read_b128 (128-bit) | 3200.00 | 14231.82 |
| ds_read_b128 (128-bit) | 6400.00 | 14287.54 |

