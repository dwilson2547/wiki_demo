**Inertial Sensors in Autonomous Vehicles**

**Overview**  
Inertial sensors, primarily Inertial Measurement Units (IMUs), measure linear acceleration and angular velocity using accelerometers and gyroscopes. When fused with other data sources, they provide robust vehicle state estimation essential for navigation, control, and sensor calibration.

**Core Components**

| Sensor | Function |
|--------|----------|
| **Accelerometer** | Measures specific force along X/Y/Z axes. |
| **Gyroscope** | Captures angular rate (roll, pitch, yaw). |
| **Magnetometer** *(optional)* | Provides heading reference relative to Earth's magnetic field. |

**Typical Specifications**

- **Accelerometers**: ±16 g range, 100–2000 Hz bandwidth.
- **Gyroscopes**: ±250/±500/±2000 deg/s range, 50–1000 Hz bandwidth.
- **Noise Density**: <10 µg/√Hz (accelerometer), <0.01°/s/√Hz (gyroscope).
- **Temperature Stability**: <0.1% per °C.

**Measurement Principles**

1. **Acceleration Integration** – Double integration of raw acceleration yields displacement; single integration provides velocity.
2. **Angular Rate Integration** – Integrating gyroscope output yields orientation angles or quaternions.
3. **Error Accumulation** – Small biases and noise lead to drift over time; requires periodic correction.

**Calibration & Error Sources**

- **Static Calibration**: Align axes, determine scale factors, zero‑bias offsets.
- **Dynamic Calibration**: Use known motions (e.g., rotations) to refine parameters.
- **Temperature Compensation**: Polynomial models or lookup tables for bias vs. temperature.
- **Cross‑Axis Sensitivity**: Minimize through careful sensor design and post‑processing.

---