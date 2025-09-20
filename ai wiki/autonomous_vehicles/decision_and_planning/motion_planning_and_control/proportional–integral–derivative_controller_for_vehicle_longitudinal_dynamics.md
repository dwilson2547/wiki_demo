**Proportional–Integral–Derivative (PID) Controller for Vehicle Longitudinal Dynamics**  

The PID controller is the workhorse of automotive control systems, providing a simple yet effective means to regulate speed or acceleration.

---

### 1. Error Signal

\[
e(t)=v_{\text{ref}}(t)-v_{\text{act}}(t)
\]

- \(v_{\text{ref}}\): Desired vehicle speed (from trajectory).  
- \(v_{\text{act}}\): Measured vehicle speed (wheel‑speed sensors + IMU).

### 2. Controller Law

\[
u(t)=K_p e(t)+K_i \int_0^t e(\tau)d\tau+K_d \frac{de}{dt}
\]

- **\(u(t)\)**: Actuator command (throttle position or brake torque).  

### 3. Tuning Methods

| Method | Process |
|--------|---------|
| Ziegler–Nichols | Increase \(K_p\) until sustained oscillations; set \(K_i,K_d\) based on ultimate gain and period. |
| Cohen–Coon | Uses step response parameters (rise time, lag). |
| Auto‑tuning | Online identification of vehicle model; compute optimal PID gains via LQR or MPC in the loop. |

### 4. Practical Enhancements

1. **Anti‑Windup**  
   - If actuator saturates: \(I_{\text{clipped}} = I_{\text{prev}} + e(t)\Delta t\).  
   - Apply back‑drift compensation.

2. **Feedforward Term**  
   - Use model prediction of required throttle for a given acceleration:
     \[
     u_{ff}=f_{\text{model}}\!\left(\frac{dv}{dt}\right)
     \]
   - Reduces tracking error during aggressive maneuvers.

3. **Deadband & Hysteresis**  
   - Avoid chattering around setpoint: ignore errors below threshold \(\epsilon\).

4. **Temperature / Load Compensation**  
   - Adjust \(K_p,K_i,K_d\) based on battery voltage or engine temperature.

### 5. Safety Considerations

- **Emergency Braking**: If error exceeds safety threshold, override PID and command maximum brake