**IMU Fusion in Autonomous Vehicles**

**Purpose**  
Integrating IMU data with other sensors (GPS, vision, lidar) yields a high‑rate, drift‑free estimate of vehicle pose—position, velocity, and orientation—critical for real‑time control and perception.

**Fusion Architectures**

1. **Kalman Filter (KF)** – Linear KF or Extended KF for moderate nonlinearity.
2. **Unscented Kalman Filter (UKF)** – Handles highly nonlinear dynamics with sigma points.
3. **Complementary Filter** – Simple weighted blending of high‑frequency IMU and low‑frequency GPS/vision data.
4. **Factor Graph / GraphSLAM** – Global optimization over multiple sensor constraints.

**State Vector Example**

\[
\mathbf{x} = \begin{bmatrix}
p_x & p_y & p_z & v_x & v_y & v_z & q_{w} & q_{x} & q_{y} & q_{z} & b_a^x & b_a^y & b_a^z & b_g^x & b_g^y & b_g^z
\end{bmatrix}^{T}
\]

- **Position** \(p\), **Velocity** \(v\)
- **Orientation** quaternion \(q\)
- **Accelerometer bias** \(b_a\), **Gyro bias** \(b_g\)

**Process Model**

- Uses IMU measurements to predict next state.
- Incorporates motion dynamics (e.g., vehicle kinematics).
- Adds process noise for sensor uncertainties.

**Measurement Models**

- **GPS**: Position, velocity, heading with ~1–5 m accuracy.
- **Vision/Lidar SLAM**: Pose constraints relative to mapped landmarks.
- **Wheel Encoders**: Ground speed, steering angle.

**Handling IMU Drift**

- Periodic correction via GPS or map‑matching reduces long‑term drift.
- Bias estimation within the filter corrects systematic errors.
- High update rates (100–200 Hz) mitigate short‑term noise impact.

---
