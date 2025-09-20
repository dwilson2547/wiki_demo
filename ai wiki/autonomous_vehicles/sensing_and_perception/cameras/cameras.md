# Cameras in Autonomous Vehicles  

Cameras are a core sensing modality for autonomous vehicles (AVs) because they provide rich, high‑resolution visual information at relatively low cost compared to Lidar or radar. In an AV context, cameras come in several types and configurations, each chosen to satisfy specific perception tasks such as traffic sign recognition, lane detection, object segmentation, and depth estimation.

## 1. Camera Types  

| Type | Wavelength Range | Typical Use Case |
|------|------------------|-----------------|
| **RGB** | Visible (400–700 nm) | General scene understanding, color‑based object detection. |
| **Infrared (IR)** | Near‑infrared (NIR, 700–1100 nm) | Low‑light or night vision; complementary to RGB under poor lighting. |
| **Thermal** | Mid‑wave (3–5 µm) / Long‑wave (8–12 µm) | Detect heat signatures of pedestrians/animals; robust to visual occlusion. |
| **Stereo** | Two synchronized RGB cameras | Depth estimation via disparity; essential for 3‑D perception. |

## 2. Mounting Configurations  

1. **Forward‑facing (single or dual)** – Provides a bird’s‑eye view of the driving corridor.  
2. **Panoramic / 360°** – Achieved by stitching multiple cameras around the vehicle; used for environment mapping and V2X.  
3. **Multi‑lens arrays** – For high‑resolution wide‑field imaging (e.g., automotive LiDAR‑like cameras).  

## 3. Image Processing Pipeline  

1. **Image Capture** – Raw sensor data acquisition at a fixed frame rate (30–60 fps).  
2. **Pre‑processing** – Lens distortion correction, white‑balance, gamma adjustment.  
3. **Feature Extraction** – Edge detection, corner points, key‑point descriptors (SIFT, ORB).  
4. **Object Detection / Segmentation** – Convolutional Neural Networks (CNNs) such as YOLOv8, EfficientDet, or Mask R-CNN.  
5. **Depth Estimation / SLAM** – Stereo matching, monocular depth prediction, simultaneous localization and mapping.  

## 4. Calibration & Synchronization  

- **Intrinsic calibration** determines the camera’s focal length, principal point, and distortion coefficients.  
- **Extrinsic calibration** aligns the camera coordinate system with the vehicle’s body frame.  
- **Temporal synchronization** ensures that images from multiple cameras or modalities (e.g., radar) correspond to the same real‑time instant; hardware trigger buses or Precision Time Protocol (PTP) are common solutions.

## 5. Challenges & Mitigation  

| Challenge | Typical Impact | Countermeasures |
|-----------|----------------|-----------------|
| **Lighting variability** | Dark scenes, glare, reflections | Use IR/thermal cameras, HDR imaging, adaptive exposure control |
| **Motion blur** | Fast vehicle speeds or vibrations | High‑speed sensors, motion compensation algorithms |
| **Occlusion / Adverse weather** | Fog, rain, dust | Polarizing filters, de‑hazing algorithms, sensor fusion with radar/Lidar |
| **Computational load** | Real‑time inference on embedded hardware | Model quantization, pruning, edge‑accelerators (NVIDIA Jetson, Intel Movidius) |

## 6. Standards & Regulations  

- **ISO 11451** – Automotive cameras and image sensors.  
- **UNECE WP.29/WP.10** – Functional safety for camera‑based perception systems.  
- **ADAS‑specific certifications** (e.g., EuroNCAP, NHTSA) require compliance with illumination, resolution, and response time criteria.

---