**Autonomous‑Vehicle Concept Tree**

```
1. Autonomous Vehicles (AV)
   ├─ 2.1 Vehicle Architecture
   │    ├─ 3.1 Powertrain & Electrical Systems
   │    │    ├─ 4.1 Battery Management (Li‑ion, solid‑state)
   │    │    └─ 4.2 Electric Drive Electronics
   │    ├─ 3.2 Mechanical Subsystems
   │    │    ├─ 4.2 Steering & Suspension
   │    │    └─ 4.3 Braking (ABS, regenerative)
   │    └─ 3.3 On‑board Computing Platform
   │         ├─ 4.3 CPU / GPU / ASIC architectures
   │         └─ 4.4 Edge‑to‑Cloud data pipelines
   │
   ├─ 2.2 Sensing & Perception
   │    ├─ 3.1 Lidar (solid‑state, rotating)
   │    │    ├─ 4.1 Point‑cloud processing
   │    │    └─ 4.2 Calibration & registration
   │    ├─ 3.2 Radar (mmWave)
   │    │    ├─ 4.1 Target detection & tracking
   │    │    └─ 4.2 Doppler velocity estimation
   │    ├─ 3.3 Cameras (RGB, Infrared, Stereo)
   │    │    ├─ 4.1 Image segmentation & object detection
   │    │    └─ 4.2 Depth estimation / SLAM
   │    ├─ 3.4 Ultrasonic & Inertial Sensors
   │    │    ├─ 4.1 IMU fusion (Kalman, EKF)
   │    │    └─ 4.2 Proximity detection
   │    └─ 3.5 Sensor Fusion
   │         ├─ 4.1 Bayesian filters (PF, MCL)
   │         └─ 4.2 Deep‑learning fusion layers
   │
   ├─ 2.3 Decision & Planning
   │    ├─ 3.1 High‑level Route Planning
   │    │    ├─ 4.1 Map‑based path generation (HD maps)
   │    │    └─ 4.2 Dynamic re‑planning (traffic, incidents)
   │    ├─ 3.2 Behavior Planning
   │    │    ├─ 4.1 Rule‑based vs ML policies
   │    │    └─ 4.2 Ethical decision modules
   │    ├─ 3.3 Motion Planning & Control
   │    │    ├─ 4.1 Trajectory generation (B-splines, MPC)
   │    │    └─ 4.2 Low‑level controllers (PID, LQR)
   │    └─ 3.4 V2X & Cooperative Driving
   │         ├─ 4.1 DSRC / C‑V2X protocols
   │         └─ 4.2 Platooning & intersection coordination
   │
   ├─ 2.4 Software Stack & Architecture
   │    ├─ 3.1 Operating Systems (AUTOSAR, ROS, QNX)
   │    ├─ 3.2 Middleware & Communication (DDS, CAN‑FD)
   │    ├─ 3.3 Real‑time Task Scheduling
   │    └─ 3.4 Continuous Integration / Deployment pipelines
   │
   ├─ 2.5 Safety & Reliability
   │    ├─ 3.1 Functional Safety (ISO 26262)
   │    │    ├─ 4.1 Hazard Analysis (FMEA, HAZOP)
   │    │    └─ 4.2 Safety Integrity Levels (ASIL)
   │    ├─ 3.2 Cyber‑Physical Security
   │    │    ├─ 4.1 Secure boot / firmware attestation
   │    │    └─ 4.2 Intrusion detection systems
   │    ├─ 3.3 Fault Detection & Isolation (FDI)
   │    │    ├─ 4.1 Redundancy strategies (hot, cold)
   │    │    └─ 4.2 Self‑diagnostics
   │    └─ 3.4 Verification & Validation (V&V) Methods
   │         ├─ 4.1 Simulation & digital twins
   │         └─ 4.2 Hardware-in-the-loop testing
   │
   ├─ 2.6 Human‑Machine Interaction (HMI)
   │    ├─ 3.1 Driver monitoring systems
   │    ├─ 3.2 In‑vehicle infotainment & UX design
   │    └─ 3.3 Transition management (autonomous ↔ manual)
   │
   ├─ 2.7 Data Management & Ethics
   │    ├─ 3.1 Data collection, labeling, and storage
   │    ├─ 3.2 Privacy‑preserving techniques (Federated learning)
   │    └─ 3.3 Bias mitigation in perception models
   │
   ├─ 2.8 Regulatory & Legal Landscape
   │    ├─ 3.1 International standards (UNECE, ISO)
   │    ├─ 3.2 Liability frameworks (product vs operator)
   │    └─ 3.3 Deployment policies & testing regulations
   │
   └─ 2.9 Ecosystem & Business Models
        ├─ 3.1 Mobility‑as‑a‑Service (MaaS) platforms
        ├─ 3.2 Infrastructure requirements (smart roads, edge nodes)
        └─ 3.3 Partnerships (OEMs, tech firms, municipalities)
```