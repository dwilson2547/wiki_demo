**Low‑Level Controllers in Autonomous Vehicles**  

After a high‑level planner (trajectory generator or MPC) produces desired states or reference signals, low‑level controllers convert these into vehicle actuator commands while ensuring stability and performance.

---

### 1. Common Actuator Channels

| Channel | Typical Control Variable |
|---------|--------------------------|
| Steering | Desired steering angle \(\delta_d\) |
| Throttle/Brake | Desired longitudinal acceleration \(a_d\) |
| Transmission | Gear selection / torque split |

### 2. PID Controller

**Structure**

\[
u(t)=K_p e(t)+K_i\int_0^t e(\tau)d\tau + K_d \frac{de}{dt}
\]

- **\(e(t)\)**: Error between reference and measured state (e.g., desired vs actual speed).  
- **Tuning**: Ziegler–Nichols, Cohen–Coon, or auto‑tuning via model identification.  

**Strengths**

- Simple, fast to implement.  
- Good for linear, low‑dynamics systems.

**Limitations**

- Not robust to large disturbances or model mismatch.  
- Integral windup if actuator limits are reached; mitigated with anti‑windup schemes.

### 3. Linear Quadratic Regulator (LQR)

**Optimal Control Problem**

\[
J = \int_0^\infty (\mathbf{x}^T Q \mathbf{x} + \mathbf{u}^T R \mathbf{u})\,dt
\]

- **\(Q,R\)**: Positive‑definite weighting matrices.  
- Solution yields state feedback law \(\mathbf{u}= -K\mathbf{x}\), where \(K = R^{-1}B^TP\).  

**Model**

- Linearized vehicle dynamics: \(\dot{\mathbf{x}}=A\mathbf{x}+B\mathbf{u}\).  
- Often used for *lateral control* (steering) or *longitudinal control* (velocity).

**Advantages**

- Provides optimal trade‑off between performance and effort.  
- Guarantees stability if \(Q,R>0\).  

**Challenges**

- Requires accurate linear model; re‑linearization may be needed in highly nonlinear regimes.  
- Does not inherently enforce actuator limits or constraints.

### 4. Model Predictive Control (MPC) as Low‑Level

When high‑level MPC is infeasible due to computation, a *short‑horizon* MPC can act as a low‑level controller:

- Horizon \(N=3–5\) steps (~0.1 s).  
- Uses simplified dynamics and linear constraints.  
- Provides robustness against disturbances.

### 5. Hybrid Approaches

| Approach | Description |
|----------|-------------|
| **PID + LQR** | PID for speed, LQR for steering; each tuned separately. |
| **Adaptive PID** | Parameters \(K_p,K_i,K_d\) updated online based on vehicle state (e.g., slip). |
| **Nonlinear MPC with Saturation** | Handles actuator limits explicitly while maintaining optimality. |

### 6. Implementation Tips

- **Sensor Fusion**: Use IMU + wheel‑speed to estimate velocity; Kalman filter reduces noise for PID error signal.  
- **Anti‑Windup**: Clip integral term when actuator saturates.  
- **Deadband**: Avoid unnecessary actuation around setpoint to reduce wear.  
- **Safety Override**: Monitor error magnitude; trigger emergency braking if thresholds exceeded.

### 7. Example Flow (Longitudinal Control)

1. High‑level planner outputs desired speed profile \(v_d(t)\).  
2. PID controller computes throttle/brake command:
   - Error \(e_v = v_d - v_{\text{meas}}\).
   - Output acceleration command \(a_c\).  
3. Vehicle dynamics model integrates \(a_c\) to update wheel speeds; saturate at actuator limits.  

---

**References**

- R. K. Smith & D. W. Jones, “Design of a LQR Controller for an Autonomous Car,” *Proceedings of the IEEE Conference on Intelligent Transportation Systems*, 2016.  
- G. S. Barros et al., “A Survey on Control Strategies for Automated Vehicles,” *IEEE Transactions on Vehicular Technology*, 2020.
