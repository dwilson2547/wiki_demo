# Target Detection & Tracking in Automotive Radar

## 1. Overview  
Automotive radar (mmWave, 77 GHz) delivers robust sensing of surrounding objects regardless of lighting or weather. **Target detection** identifies individual reflectors in the raw return; **tracking** associates successive detections to build continuous trajectories.

---

## 2. Signal Chain Recap
| Stage | Purpose |
|-------|---------|
| Pulse Generation | Transmit chirp (linear frequency modulation) |
| Channel Mixing | Down‑convert reflected signal to baseband |
| ADC & DSP | Digitize, filter, FFT → range–Doppler map |
| Clutter Suppression | Moving target indication (MTI), CFAR |

---

## 3. Detection Algorithms

### 3.1 Constant False Alarm Rate (CFAR)  
- **Cell‑averaging (CA‑CFAR)**: Estimate noise from surrounding cells, set threshold = α × noise + offset.  
- **Order‑Statistic (OS‑CFAR)**: Uses order statistics for non‑Gaussian clutter.  
- **Implementation Tips**:  
  - Use *window size* that covers at least two Doppler bins per target to avoid self‑clutter.  
  - Adaptive *α* selection based on desired false alarm rate (FAR).  

### 3.2 Matched Filtering & Peak Picking  
- Apply matched filter to range profile for peak sharpening.  
- Use a **local maximum** search with hysteresis to reduce ghost detections.

### 3.3 Machine‑Learning Enhancements  
- **CNNs on Range–Doppler maps**: Detect clusters and classify as vehicle / pedestrian / static obstacle.  
- *Training*: Simulated data + real‑world annotated radar captures.  

---

## 4. Tracking Framework

| Tracker | Key Idea | Pros | Cons |
|---------|----------|------|------|
| **Kalman Filter (KF)** | Linear Gaussian assumption; state = [range, range_rate, azimuth] | Fast, simple | Fails with non‑linear motion or multi‑modal uncertainty |
| **Extended Kalman Filter (EKF)** | Linearizes around estimate | Handles basic non‑linearity | Requires Jacobian; can diverge |
| **Unscented Kalman Filter (UKF)** | Uses sigma points for better non‑linear propagation | Better accuracy | Higher computational load |
| **Particle Filter** | Monte‑Carlo representation of posterior | Handles arbitrary distributions | Very high CPU cost |

### 4.1 Data Association  
- **Nearest Neighbor (NN)**: Assign detection to the closest predicted track if within gating threshold.  
- **Joint Probabilistic Data Association (JPDA)**: Considers multiple association hypotheses; mitigates mis‑association in dense scenes.  

### 4.2 Track Management  
- **Birth**: New detections that persist > N frames become tracks.  
- **Confirmation / Deletion**: Tracks are confirmed after M hits, deleted if missed for L consecutive frames.  
- **Merging / Splitting**: Resolve track fusion when two tracks converge; split if divergence exceeds threshold.

---

## 5. Practical Considerations

| Issue | Mitigation |
|-------|------------|
| **Clutter & Multipath** | Use CFAR with high guard cells; apply range‑Doppler pruning based on known radar beam pattern. |
| **Co‑channel Interference** | Frequency hopping or time division multiplexing among multiple radars in the same vehicle. |
| **Computational Load** | GPU acceleration for FFT & CNNs; fixed‑point DSP for KF/UKF. |
| **Latency** | Target detection < 1 ms, tracking < 5 ms to meet control loop requirements. |

---

## 6. Key Performance Metrics

- **Detection Probability (Pd)** at various ranges and clutter densities.
- **False Alarm Rate (FAR)** per range–Doppler cell.
- **Tracking Accuracy**: Root‑mean‑square error in range, speed, bearing.
- **Track Continuity**: Percentage of time a true target remains tracked.

---

## 7. Typical Use Cases

1. **Adaptive Cruise Control (ACC)** – Detect and track lead vehicles to maintain safe gap.  
2. **Automatic Emergency Braking (AEB)** – Rapidly detect pedestrian or cyclist approaching the lane.  
3. **Intersection Management** – Track cross‑traffic vehicles for intersection coordination.

---

## 8. References

1. R. A. Smith et al., “mmWave Radar Signal Processing,” *IEEE Sensors Journal*, vol. 19, no. 4, 2019.  
2. S. Lee & J. Kim, “Deep Learning for Radar Target Classification,” *Proc. IEEE ICASSP*, 2021.  
3. Bosch Sensortec, *Radar Sensor Handbook*, 2020.

---

