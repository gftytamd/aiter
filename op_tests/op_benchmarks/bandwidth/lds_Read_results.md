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
| ds_read_b64 (64-bit) | 20.00 | 10994.82 |
| ds_read_b64 (64-bit) | 1280.00 | 13965.15 |
| ds_read_b64 (64-bit) | 3200.00 | 14111.23 |
| ds_read_b64 (64-bit) | 6400.00 | 14157.05 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_read_b128 (128-bit) | 20.00 | 12657.45 |
| ds_read_b128 (128-bit) | 1280.00 | 14086.62 |
| ds_read_b128 (128-bit) | 3200.00 | 14192.63 |
| ds_read_b128 (128-bit) | 6400.00 | 14264.03 |

