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
| ds_write_b64 (64-bit) | 20.00 | 9195.20 |
| ds_write_b64 (64-bit) | 1280.00 | 830966.58 |
| ds_write_b64 (64-bit) | 3200.00 | 715321.26 |
| ds_write_b64 (64-bit) | 6400.00 | 893256.82 |

### 128-bit Operations

| Operation | Data Size (MB) | Bandwidth (GB/s) |
|-----------|---------------:|----------------:|
| ds_write_b128 (128-bit) | 20.00 | 440578.16 |
| ds_write_b128 (128-bit) | 1280.00 | 763294.63 |
| ds_write_b128 (128-bit) | 3200.00 | 853713.20 |
| ds_write_b128 (128-bit) | 6400.00 | 924309.81 |

