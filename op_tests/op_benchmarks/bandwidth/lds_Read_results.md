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
| ds_read_b64 (64-bit) | 20.00 | 10979.24 |
| ds_read_b64 (64-bit) | 1280.00 | 14002.07 |
| ds_read_b64 (64-bit) | 3200.00 | 14135.43 |
| ds_read_b64 (64-bit) | 6400.00 | 14189.11 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_read_b128 (128-bit) | 20.00 | 12692.27 |
| ds_read_b128 (128-bit) | 1280.00 | 14110.12 |
| ds_read_b128 (128-bit) | 3200.00 | 14230.02 |
| ds_read_b128 (128-bit) | 6400.00 | 14299.08 |

