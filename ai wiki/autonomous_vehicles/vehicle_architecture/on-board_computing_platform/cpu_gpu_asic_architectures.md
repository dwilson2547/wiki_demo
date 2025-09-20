**CPU / GPU / ASIC Architectures**

On‑board computing platforms in autonomous vehicles are the “brains” that fuse sensor data, run perception, planning, and control algorithms, and interface with both vehicle hardware and external services. A typical platform stacks three layers of compute:

| Layer | Typical Devices | Key Attributes |
|-------|-----------------|----------------|
| **CPU (Central Processing Unit)** | ARM Cortex‑A series, Intel Xeon, AMD EPYC, Nvidia Tegra | General‑purpose processing; low‑latency control loops; handles system management. |
| **GPU (Graphics Processing Unit)** | Nvidia Xavier NX/AGX, AMD Radeon Pro, custom FPGA‑based GPUs | Massively parallel compute for deep‑learning inference and simulation. |
| **ASIC / Heterogeneous SoC** | Nvidia Drive PX series, Tesla Dojo, Qualcomm Snapdragon Ride | Application‑specific designs with integrated accelerators (CNN engines, tensor cores) and high‑bandwidth memory. |

### CPU Design Considerations

- **Low‑Power Multi‑Core Architectures** – 4–8 cores at ~1 GHz provide deterministic timing for control loops.  
- **Real‑Time Operating Systems (RTOS)** – Linux‑based RTOS or AUTOSAR Adaptive for scheduling high‑priority tasks.  
- **Hardware Security Modules** – Secure boot, cryptographic accelerators, and Trusted Execution Environments (TEE) to guard against tampering.

### GPU Acceleration

- **Tensor Cores / CUDA Streams** – Enable efficient inference of convolutional neural networks (CNNs) with > 100 TOPS.  
- **Unified Memory Architecture** – Simplifies data sharing between CPU and GPU, reducing copy overhead.  
- **Dynamic Voltage & Frequency Scaling (DVFS)** – Balances performance against thermal headroom.

### ASIC / Custom SoC

- **Application‑Specific CNN Engines** – Process 3D point clouds, stereo depth, and semantic segmentation in < 10 ms.  
- **High‑Bandwidth Memory (HBM2/HBM3)** – Supports > 1 TB/s memory bandwidth for large models.  
- **Embedded Networking** – 100 Gbps Ethernet, CAN‑FD, and optical interfaces all on-chip.

### Integration & Modularity

| Feature | Description |
|---------|-------------|
| **PCIe Express Expansion** | Allows adding dedicated vision or radar accelerators without redesigning the base board. |
| **Modular Board Design** | Swappable sensor interface boards (LiDAR, camera) to support OEM upgrades. |
| **Thermal Management** | Multi‑layer heat spreaders and liquid cooling loops keep die temperatures < 80 °C under full load. |

### Benchmarking & Performance Metrics

- **Inference Latency** – Target < 50 ms for front‑sensor perception pipelines.  
- **Throughput** – 100–200 frames per second (fps) for high‑resolution cameras, 10–20 Hz for LiDAR point clouds.  
- **Power Envelope** – Typical on‑board compute clusters consume 150–300 W; automotive-grade silicon optimizes for < 250 W under peak load.

### Standards & Certifications

- ISO 26262 (ASIL‑D) – Functional safety for high‑voltage and power electronics integrated with the compute platform.  
- SAE J3061 – Cybersecurity Management System (CSMS) for autonomous vehicles.  
- IEC 61508 – Reliability and safety of electronic components.
