# Depth Estimation & SLAM for Autonomous Vehicles  

Depth perception converts 2D images into 3‑D spatial information, enabling collision avoidance and map building. Simultaneous Localization and Mapping (SLAM) uses depth cues to both localize the vehicle and construct a coherent environment model.

## 1. Depth Estimation Methods  

### 1.1 Stereo Vision  
- **Principle**: Triangulate disparity between two rectified images.  
- **Algorithms**: Semi‑Global Matching (SGM), Block Matching, DeepStereo.  
- **Pros/Cons**: High accuracy at close range; performance degrades with textureless surfaces or large baselines.

### 1.2 Monocular Depth Prediction  
- **Deep Learning Models**: DenseDepth, DPT, MiDaS.  
- **Training**: Supervised (LiDAR‑depth ground truth) or self‑supervised via photometric consistency.  
- **Limitations**: Scale ambiguity; requires fine‑tuning for specific scenes.

### 1.3 Hybrid Approaches  
- Combine stereo disparity with monocular depth priors to improve robustness under challenging lighting and weather conditions.

## 2. SLAM Pipeline  

| Stage | Key Processes |
|-------|---------------|
| **Feature Extraction** | ORB, SIFT, or learned descriptors (SuperPoint). |
| **Data Association** | Matching features across frames; RANSAC for outlier rejection. |
| **Pose Estimation** | Visual Odometry (VO) using PnP + EKF or direct methods (Direct Sparse Odometry). |
| **Map Construction** | 3‑D point cloud generation, loop closure detection via bag‑of‑words or learned embeddings. |
| **Optimization** | Graph SLAM back‑end (g2o, Ceres) to minimize pose and landmark errors. |

## 3. Loop Closure & Global Consistency  

- **Detection**: Visual place recognition using NetVLAD or DBoW2; confirm with geometric verification.  
- **Correction**: Apply global bundle adjustment after loop detection to correct drift.  

## 4. Integration with Other Modalities  

- **LiDAR‑SLAM Fusion**: Use LiDAR point clouds for robust depth, while cameras provide semantic labeling (e.g., “car”, “pedestrian”).  
- **Kalman Filtering**: Fuse visual pose estimates with IMU and wheel odometry to reduce drift.  

## 5. Real‑Time Constraints  

- **Parallelization**: Separate threads for feature extraction, matching, and optimization.  
- **Hardware Acceleration**: GPU‑based descriptors, FPGA implementations of SGM.  
- **Dynamic Re‑allocation**: Prioritize SLAM in high‑complexity scenes; fall back to pre‑built HD maps in low‑dynamics areas.

## 6. Safety & Validation  

- **Benchmark Datasets**: KITTI Odometry, Oxford RobotCar, ApolloScape.  
- **Robustness Testing**: Evaluate under varying illumination, weather, and dynamic object densities.  
- **Safety Analysis**: Quantify pose error bounds; ensure navigation decisions remain within tolerable drift limits per ISO 26262.

---
