# Bayesian Sensor Fusion in Autonomous Vehicles  

Bayesian sensor fusion applies probabilistic models—most commonly Kalman Filters (KF), Extended/Unscented Kalman Filters (EKF/UKF), and Particle Filters (PF)—to merge noisy measurements from multiple sensors into a single estimate of the vehicle’s state or surrounding environment.  

## 1. Bayesian Foundations

| Concept | Definition |
|---------|------------|
| **Prior** | Belief about the state before incorporating new data. |
| **Likelihood** | Probability of observing measurement given a hypothesized state. |
| **Posterior** | Updated belief after considering the likelihood; obtained via Bayes’ rule. |

Bayesian fusion iteratively updates the posterior as each new sensor reading arrives, naturally handling uncertainty and temporal dynamics.

## 2. Kalman Filter (KF)

- **Assumptions:** Linear system dynamics, Gaussian noise.  
- **Equations:**
  - *Predict:* \( \hat{x}_{k|k-1} = A\hat{x}_{k-1|k-1} + Bu_{k-1} \)  
    \( P_{k|k-1} = AP_{k-1|k-1}A^T + Q \)
  - *Update:* \( K_k = P_{k|k-1}H^T(HP_{k|k-1}H^T+R)^{-1} \)  
    \( \hat{x}_{k|k} = \hat{x}_{k|k-1} + K_k(z_k - H\hat{x}_{k|k-1}) \)  
    \( P_{k|k} = (I-K_kH)P_{k|k-1} \)

**Use Cases:**  
- Vehicle pose estimation combining IMU, GPS, wheel odometry.  
- Tracking of dynamic obstacles with linear motion models.

## 3. Extended/Unscented Kalman Filters

- **EKF** linearizes nonlinear dynamics around the current estimate; suitable for moderate nonlinearity.  
- **UKF** propagates a set of sigma points through the nonlinear functions, offering better accuracy for highly nonlinear systems (e.g., radar range–velocity to Cartesian coordinates).

## 4. Particle Filter (PF)

- **Non‑Gaussian, Nonlinear**: represents posterior with weighted particles.  
- **Algorithm Steps:** prediction, weighting based on likelihood, resampling.  
- **Applications:**  
  - Localization in complex environments (Monte Carlo Localization).  
  - Multi‑modal uncertainty handling (e.g., ambiguous sensor data).

## 5. Implementation Considerations

| Aspect | Guidance |
|--------|----------|
| **Sensor Model** | Accurate noise covariance \( R \) per modality; consider cross‑correlations. |
| **State Vector Design** | Include position, velocity, heading, and optional higher‑order terms (e.g., acceleration). |
| **Computational Budget** | KF is lightweight; PF scales with particle count—trade‑off between accuracy and latency. |
| **Real‑time Constraints** | Use fixed‑point arithmetic or hardware accelerators for high update rates (~100 Hz). |

## 6. Multi‑Sensor Fusion Workflow

1. **Define a Unified State Vector** (e.g., vehicle pose + obstacle positions).  
2. **Model Each Sensor’s Measurement Equation** \( z = h(x) + v \).  
3. **Choose the Filter Type** based on linearity and required precision.  
4. **Tune Process/Measurement Covariances** via offline calibration or online adaptation (e.g., adaptive KF).  
5. **Validate with Ground Truth** (motion capture, high‑accuracy GNSS) to assess RMSE.