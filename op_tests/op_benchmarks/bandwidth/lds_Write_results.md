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
| ds_write_b64 (64-bit) | 20.00 | 6342.11 |
| ds_write_b64 (64-bit) | 1280.00 | 9312.61 |
| ds_write_b64 (64-bit) | 3200.00 | 9484.78 |
| ds_write_b64 (64-bit) | 6400.00 | 9544.15 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_write_b128 (128-bit) | 20.00 | 7259.06 |
| ds_write_b128 (128-bit) | 1280.00 | 9258.75 |
| ds_write_b128 (128-bit) | 3200.00 | 9476.63 |
| ds_write_b128 (128-bit) | 6400.00 | 9551.15 |

