**Lidar – Calibration & Registration**

Calibration aligns the LiDAR coordinate frame with other vehicle sensors and with a global reference (e.g., GPS/IMU). Registration fuses multiple LiDAR scans over time to build a consistent map.

| **Aspect** | **Purpose** | **Common Techniques** |
|------------|-------------|-----------------------|
| **Extrinsic Calibration (LiDAR ↔ Camera / IMU)** | Transform points into common frame for multi‑sensor fusion. | Hand‑eye calibration, checkerboard or planar marker methods, nonlinear bundle adjustment. |
| **Intrinsic Calibration (Laser Beam Geometry)** | Correct systematic distortions due to manufacturing tolerances. | Laser line fitting, multi‑scan alignment of static scenes. |
| **Temporal Synchronization** | Ensure that sensor timestamps are aligned to avoid motion blur. | Hardware triggers, PPS (Pulse Per Second) from GPS, software timestamp correction. |
| **Scan‑to‑Map Registration** | Accumulate successive scans into a global map. | ICP (Iterative Closest Point), NDT (Normal Distributions Transform), LOAM (Lidar Odometry & Mapping). |
| **Loop Closure Detection** | Identify revisited locations to correct drift. | Feature matching (SHOT, FPFH), place recognition networks (ScanContext). |

### Calibration Workflow

1. **Setup** – Mount LiDAR, cameras, and IMU on a calibration rig; fix known targets.  
2. **Data Capture** – Record synchronized streams while moving the vehicle or rotating the sensor platform.  
3. **Initial Guess** – Use rough extrinsic estimates from mechanical measurements.  
4. **Optimization** – Minimize reprojection error across all modalities (e.g., projecting LiDAR points onto camera images).  
5. **Validation** – Verify by comparing transformed point clouds against ground‑truth maps or high‑accuracy GNSS data.

### Registration Strategies

- **Direct Scan Matching**  
  - *ICP*: Minimizes point‑to‑point distances; requires good initial guess.  
  - *NDT*: Uses probability density functions for robust matching in sparse scenes.
- **Feature‑Based Matching**  
  - Extract keypoints (e.g., ISS, Harris3D) and descriptors (SHOT, FPFH); match across scans to obtain coarse alignment.  
  - Refine with ICP or NDT.

### Drift Mitigation

- **VIO/IMU Integration** – Fuse high‑rate IMU data with LiDAR odometry for short‑term accuracy.  
- **Global Localization** – Periodic GPS fixes or map‑based place recognition to re‑center the pose graph.  

### Performance Metrics

- **Extrinsic Accuracy** – ≤ 5 mm translation, ≤ 0.5° rotation error.  
- **Registration RMSE** – < 10 cm for 64‑beam LiDAR over a 200 m path.  
- **Runtime** – ICP on GPU: < 20 ms per scan (on NVIDIA Jetson AGX).  

### Safety & Standards

- ISO 26262 – Validation of sensor fusion pipelines to meet ASIL‑C requirements.  
- SAE J3061 – Cybersecurity for sensor data integrity during calibration and operation.