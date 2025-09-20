**Lidar – Point‑Cloud Processing**

LiDAR (Light Detection And Ranging) provides dense 3D measurements by emitting laser pulses and measuring the return time. The raw output is a *point cloud* that must be processed in real time to support perception, mapping, and planning.

| **Processing Stage** | **Goal** | **Typical Algorithms / Tools** |
|----------------------|----------|--------------------------------|
| **Pre‑processing** | Remove noise, downsample for speed | Voxel Grid filter, Statistical Outlier Removal (SOR), Radius Outlier Removal |
| **Ground Segmentation** | Separate drivable surface from obstacles | RANSAC plane fitting, Morphological segmentation, Hough Transform |
| **Object Detection & Clustering** | Identify discrete objects (vehicles, pedestrians) | Euclidean Cluster Extraction, DBSCAN, K‑means, PointNet/PointCNN for semantic labeling |
| **Feature Extraction** | Describe object shape and pose | FPFH (Fast Point Feature Histograms), Spin Images, PCA‑based orientation |
| **Tracking** | Maintain identity over time | Kalman Filter / Extended Kalman Filter (EKF), Hungarian Algorithm + MHT, DeepSORT |
| **Semantic Segmentation** | Classify each point or cluster | 3D CNNs (PointNet++, MinkowskiNet), Random Forests on hand‑crafted features |
| **Map Integration** | Fuse into a global occupancy map | Octree / KD‑tree insertion, Bayesian fusion of multi‑scan data |

### Key Challenges & Mitigations

- **High Data Rate (10–70 Hz)** → Use GPU acceleration and spatial hashing to keep latency < 30 ms.  
- **Sparse Returns at Long Range** → Adaptive voxel size or intensity‑based weighting improves feature robustness.  
- **Dynamic Scene (moving cars, pedestrians)** → Motion compensation via IMU/odometry before clustering.  

### Example Pipeline Flow

```
[Raw Point Cloud] → [Pre‑processing]
          │
          ├─> [Ground Removal] → [Object Clustering]
          │                            │
          │                            └─> [Feature Extraction] → [Semantic Classifier]
          │                                            │
          └─> [Tracking Module] → [Trajectory Prediction] → [Planner Input]
```

### Software Libraries

| Library | Language | Highlights |
|---------|----------|------------|
| **PCL (Point Cloud Library)** | C++ | Comprehensive set of filters, segmentation, and visualization tools. |
| **Open3D** | Python/C++ | Modern GPU‑accelerated pipelines, deep‑learning integration. |
| **lidar-tools** (ROS 2) | Python | ROS‑based wrappers for common LiDAR sensors. |
| **TensorFlow Lite / PyTorch Mobile** | Python | Deploy lightweight CNNs on edge GPUs or NPUs. |

### Performance Metrics

- **Latency** – End‑to‑end processing < 30 ms per frame (for 64‑beam LiDAR at 10 Hz).  
- **Accuracy** – Point‑cloud registration RMSE < 3 cm; object detection mAP > 0.8 for pedestrians.  
- **Throughput** – Process ≥ 1 M points/s on an NVIDIA Jetson AGX Xavier (CUDA).

### Standards & Safety

- ISO 26262 (ASIL‑B/C) – Functional safety of LiDAR sensor interfaces and processing pipelines.  
- SAE J3016 – Level 4/5 automation perception requirements.  