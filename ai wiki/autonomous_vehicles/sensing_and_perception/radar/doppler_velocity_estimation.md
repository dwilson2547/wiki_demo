# Doppler Velocity Estimation in Automotive Radar

## 1. Introduction  
The **Doppler effect** allows radar to measure relative radial velocity between the transmitter and a target by observing frequency shift of returned chirps. Accurate velocity estimation is critical for collision avoidance, adaptive cruise control, and traffic‑flow monitoring.

---

## 2. Chirp Design & Frequency Modulation

| Parameter | Typical Value (mmWave) | Effect |
|-----------|------------------------|--------|
| Bandwidth (B) | 1 GHz – 4 GHz | Determines range resolution ΔR = c/(2B) |
| Sweep Time (T_s) | 50 µs – 100 µs | Determines Doppler resolution Δv = λ/(2T_s) |
| Chirp Repetition Rate (CRR) | 5 kHz – 20 kHz | Sets maximum unambiguous velocity and update rate |

*Equation:*  
For a linear chirp \( f(t)=f_0 + \frac{B}{T_s}t \), the received signal is delayed by τ = 2R/c. The beat frequency:
\( f_b = \frac{B}{T_s}\tau + f_D \)  
where \( f_D = \frac{2v}{\lambda} \).

---

## 3. Range–Doppler Processing

1. **FFT in Range** (per chirp) → range bins.  
2. **FFT in Doppler** (across N_chirps per coherent processing interval, CPI) → Doppler bins.

*Key equations:*  
- Doppler bin spacing: \( \Delta f_D = \frac{1}{N_{\text{chirp}}T_s} \).  
- Velocity resolution: \( \Delta v = \frac{\lambda}{2 N_{\text{chirp}} T_s} \).

**Unambiguous Velocity**:  
\( v_{\max} = \frac{\lambda}{4T_s} \) (half the sampling frequency of Doppler FFT).

---

## 4. Estimation Techniques

### 4.1 Peak Picking  
- Identify maximum magnitude in Doppler bin; estimate velocity directly from bin index.

*Pros:* Simple, low latency.  
*Cons:* Limited resolution, quantization error.

### 4.2 Sub‑Bin Interpolation  
- **Parabolic Fit** around peak:  
\( v = v_0 + \frac{\lambda}{4T_s} \cdot \frac{a - b}{a + b - 2c} \) where a,b,c are neighboring bin magnitudes.

### 4.3 Maximum Likelihood Estimation (MLE)  
- Model received waveform; maximize likelihood over velocity parameter.  
- Provides statistically optimal estimates but computationally heavier.

### 4.4 Kalman‑Based Velocity Smoothing  
- Treat Doppler estimate as measurement; KF refines velocity using motion model (constant acceleration, etc.).

---

## 5. Practical Issues & Mitigations

| Issue | Effect | Solution |
|-------|--------|----------|
| **Multipath** | Creates false Doppler peaks | Apply adaptive CFAR gating; use high‑resolution FFT |
| **Phase Noise** | Broadens Doppler bins | Use low‑phase‑noise oscillators; digital phase tracking |
| **Target RCS Variability** | Fluctuating amplitude can bias peak detection | Weighted averaging over CPI; robust outlier rejection |
| **Aliasing (High Velocity)** | Velocities beyond \(v_{\max}\) fold back | Increase chirp sweep time, use multiple CPIs with different T_s |

---

## 6. Integration into Perception Pipeline

1. **Detection** – Identify target range bins via CFAR.  
2. **Velocity Estimation** – Apply sub‑bin interpolation or KF to Doppler bin of each detection.  
3. **Tracking** – Combine velocity estimate with position in Kalman filter for full state vector.

---

## 7. Key Performance Metrics

- **Velocity RMSE** at various SNR levels (e.g., < 0.5 m/s at 30 dB).  
- **Unambiguous Velocity Range** (≥ ± 120 km/h for automotive).  
- **Latency** – Total time from chirp transmission to velocity output (< 1 ms).

---

## 8. Advanced Topics

| Topic | Brief |
|-------|-------|
| **Multi‑Target Velocity Estimation** | Joint detection and velocity estimation using sparse reconstruction (e.g., LASSO). |
| **Beamforming & Angular Velocity** | Combine Doppler with azimuth angle to estimate lateral speed for lane‑changing scenarios. |
| **Cooperative Radar (C‑V2X)** | Share Doppler info between vehicles for enhanced situational awareness. |

---

## 9. References

1. J. B. Rader, *Principles of Modern Radar: Basic Principles*, 3rd ed., McGraw‑Hill, 2010.  
2. K. H. Lee & S. Park, “High‑Resolution Doppler Estimation for Automotive Radar,” *Proc. IEEE ICASSP*, 2022.  
3. Bosch Sensortec, *mmWave Radar Data Sheet*, 2021.

---
