# Autonomous Vehicles – Software Stack & Architecture  

The **Software Stack & Architecture** of an autonomous vehicle (AV) is the foundation that enables perception, decision‑making, control, and safety functions to run reliably in real time on automotive hardware. This section provides a comprehensive overview of the key software layers, design principles, and industry standards that underpin modern AV systems.

---

## 1. Operating Systems  

### 1.1 AUTOSAR (Automotive Open System Architecture)  
- **Definition**: A standardized architecture for automotive ECUs that separates application logic from underlying hardware.  
- **Layers**:  
  - *Basic Software (BSW)* – drivers, communication stack, memory services.  
  - *Runtime Environment (RTE)* – middleware providing component interaction.  
  - *Application Layer* – vehicle‑specific software modules.  
- **Benefits**: Reusability, safety certification support (ISO 26262), and easier integration of components from multiple vendors.  

### 1.2 ROS (Robot Operating System)  
- **Purpose**: A flexible framework for robot software development; widely adopted in research AV prototypes.  
- **Key Concepts**:  
  - *Nodes*: Independent processes communicating via topics, services, or actions.  
  - *Message Passing*: Zero‑MQ based transport with optional DDS integration.  
  - *Tools*: `rviz` (visualization), `rosbag` (recording/playback).  
- **Challenges for Production**: Determinism, memory safety, and real‑time constraints.  

### 1.3 Real‑Time Operating Systems (RTOS) – QNX, VxWorks, FreeRTOS  
- **Deterministic Scheduling**: Priority‑based preemptive schedulers guarantee bounded latency.  
- **Safety Features**: Memory protection units (MPUs), safe‑boot mechanisms, and fault isolation.  
- **Use Cases**: Low‑level control loops, safety‑critical subsystems, or hybrid stacks where a non‑RTOS layer runs atop an RTOS for higher‑level tasks.  

### 1.4 Linux‑based Real‑Time Extensions (PREEMPT_RT)  
- **Advantages**: Large ecosystem of drivers and tooling; can be hardened with SELinux, AppArmor, and seccomp filters.  
- **Typical Configuration**: Kernel patched for low‑latency, real‑time scheduler (`SCHED_FIFO`/`SCHED_RR`), and minimal interrupt latency.  

---

## 2. Middleware & Communication  

### 2.1 Data Distribution Service (DDS)  
- **Standard**: IEEE 1516; provides a publish/subscribe model with Quality of Service (QoS) controls (latency, reliability).  
- **Application in AVs**: Inter‑ECU communication for perception data sharing, sensor fusion, and vehicle‑to‑vehicle (V2X) messaging.  

### 2.2 Controller Area Network (CAN) & CAN‑FD  
- **Legacy**: Widely used for low‑bandwidth, safety‑critical signals (brake status, door locks).  
- **CAN‑FD**: Enhanced frame format supports up to 64 bytes payload and higher data rates (~1 Mbps), enabling richer telemetry.  

### 2.3 Ethernet & Time‑Sensitive Networking (TSN)  
- **High Bandwidth**: Required for sensor streams (HD video, Lidar point clouds).  
- **Determinism**: TSN extensions (IEEE 802.1AS, 802.1Qbv) guarantee bounded latency and jitter, essential for safety‑critical data paths.  

### 2.4 Software‑Defined Networking (SDN) in AVs  
- **Centralized Control Plane**: Enables dynamic routing of sensor streams to compute nodes, load balancing across GPUs/CPUs, and isolation between safety and infotainment networks.  

---

## 3. Real‑Time Task Scheduling  

### 3.1 Fixed‑Priority Preemptive Scheduling (FPS)  
- **Mechanism**: Each task is assigned a static priority; higher‑priority tasks preempt lower ones.  
- **Analysis Tools**: Response time analysis, utilization bounds (e.g., Liu & Layland).  

### 3.2 Earliest Deadline First (EDF)  
- **Dynamic Priority**: Tasks are prioritized by the imminence of their deadlines.  
- **Optimality**: EDF can achieve 100 % CPU utilisation on a uniprocessor system under certain assumptions.  

### 3.3 Multi‑Core Scheduling & Partitioning  
- **Static Partitioning**: Assigns tasks to cores at design time; reduces inter‑core communication overhead.  
- **Dynamic Work‑Sharing**: Uses global scheduling policies (e.g., Global EDF) but requires careful handling of cache affinity and migration costs.  

### 3.4 Mixed‑Criticality Scheduling  
- **Concept**: Different tasks have varying safety significance (high vs low).  
- **Approach**: High‑criticality tasks run with guaranteed resources; low‑criticality tasks are throttled or suspended if CPU load exceeds a threshold.  

---

## 4. Continuous Integration / Deployment (CI/CD) Pipelines  

### 4.1 Build Automation  
- **Tools**: CMake, Bazel, and Ninja for cross‑platform builds.  
- **Containerization**: Docker images encapsulate toolchains (e.g., GCC, Clang) ensuring reproducible builds.  

### 4.2 Static Analysis & Code Quality  
- **Linters**: cppcheck, clang‑tidy, Coverity for detecting bugs early.  
- **Formal Verification**: Model checking of safety properties (e.g., using SPIN or UPPAAL).  

### 4.3 Automated Testing Suites  
- **Unit Tests**: Google Test / Catch2; run on embedded hardware simulators.  
- **Integration Tests**: ROS integration tests, DDS QoS validation.  
- **Hardware‑in‑the‑Loop (HIL)**: Simulate ECU interactions with real sensor data streams.  

### 4.4 Deployment & Over‑The‑Air (OTA) Updates  
- **Secure Boot**: Verify firmware integrity before execution.  
- **Rollback Mechanisms**: Dual image partitions; if a new build fails, system reverts to the previous stable image.  

---

## 5. Design Principles for AV Software Stack  

1. **Modularity & Encapsulation** – Each functional module exposes clear interfaces; reduces coupling.  
2. **Determinism & Predictability** – Real‑time guarantees for safety‑critical tasks.  
3. **Scalability** – Ability to add new sensors, compute nodes, or vehicle models without redesigning the entire stack.  
4. **Security & Trustworthiness** – Enforce strict authentication/authorization across all communication channels; protect against injection and replay attacks.  

---

## 6. Industry Standards & Certifications  

- **ISO 26262** – Functional safety for automotive electronics.  
- **MISRA‑C/C++** – Coding guidelines to avoid undefined behaviour.  
- **IEC 61508** – General functional safety for electronic systems.  
- **SAE J3061** – Cybersecurity management for connected vehicles.  

---

### 7. Typical AV Software Stack Diagram  

```
+---------------------------------------------------------------+
|                    Autonomous Vehicle OS                     |
|   +-------------------+    +---------------------------+     |
|   |      AUTOSAR BSW   |    |        RTOS (QNX)        |     |
|   +-------------------+    +---------------------------+     |
|         ^                            ^                        |
|         |                            |                        |
|   +---------------------------------------------+            |
|   |                Middleware Layer              |            |
|   |  (DDS, CAN‑FD, TSN Ethernet, ROS)           |            |
|   +---------------------------------------------+            |
|          ^             ^               ^                      |
|          |             |               |                      |
|   +------+-----+ +----+---+ +---------+--------+              |
|   |  Perception | | Planning | | Control & Actuation |        |
|   | (Lidar, Radar, Camera) | | (MPC, Behavior) | | (PID, CAN) |
|   +--------------+ +----------+ +------------------+            |
|          ^             ^               ^                      |
|          |             |               |                      |
|   +-----------------------------------------------+          |
|   |      Safety & Security Services                |         |
|   |  (Secure Boot, FDI, Fault Isolation)           |         |
|   +-----------------------------------------------+          |
|                        ...                                 |
+---------------------------------------------------------------+
```

---

**Key Takeaways**

- A robust AV software stack must integrate deterministic real‑time operating systems with flexible middleware to handle heterogeneous sensor data.  
- Safety and security are woven into every layer, from secure boot and memory protection in the OS to fault isolation in the application modules.  
- Continuous integration pipelines enforce code quality, safety verification, and secure deployment—critical for scaling AV fleets.

---  

@PAGEENDNeed multiple wiki pages for each topic under Software Stack & Architecture: Operating Systems, Middleware & Communication, Real-time Task Scheduling, CI/CD pipelines. Provide detailed content. Use markers.@PAGESTART  
# Autonomous Vehicle Software Stack & Architecture – Overview  

Autonomous vehicles (AVs) rely on a highly modular, fault‑tolerant software stack that bridges low‑level hardware control with high‑level decision making. The stack is typically layered into four broad categories: **Operating System (OS)**, **Middleware / Communication**, **Real‑time Task Scheduling**, and **Continuous Integration / Continuous Deployment (CI/CD)** pipelines.  

The following wiki pages break down each category in depth, covering key concepts, industry standards, common implementations, and best practices for safety‑critical automotive systems.

---