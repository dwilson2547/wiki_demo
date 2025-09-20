# Failure Mode and Effects Analysis (FMEA) for Autonomous Vehicle Subsystems  

Failure Mode and Effects Analysis (FMEA) is a systematic technique used to identify potential failure modes within a system, assess their impact on safety, and prioritize mitigation actions. In autonomous vehicles (AV), FMEA spans from low‑level hardware components to high‑level software modules.

## 1. FMEA Basics  

| Term | Meaning |
|------|---------|
| **Failure Mode** | Specific way a component can fail (e.g., “lidar sensor blind spot”). |
| **Effect** | Consequence of the failure on vehicle safety or functionality. |
| **Cause** | Root cause leading to the failure mode. |
| **Severity (S)** | 1–10 scale; 10 = fatal injury, 1 = negligible. |
| **Occurrence (O)** | 1–10 scale; 10 = likely in normal use, 1 = extremely rare. |
| **Detection (D)** | 1–10 scale; 10 = unlikely to detect before failure, 1 = highly detectable. |
| **Risk Priority Number (RPN)** | RPN = S × O × D. |

## 2. FMEA Process Flow  

1. **Select the Subsystem** – e.g., *Steering Control Unit*.  
2. **Define Functions** – “Maintain vehicle lane position”.  
3. **Identify Failure Modes** –  
   - Actuator stalls → loss of steering control.  
   - ECU software crash → no command output.  
4. **Determine Effects & Severity** –  
   - Loss of steering control → S = 9 (potential collision).  
5. **Assess Occurrence & Detection** –  
   - Actuator stall: O = 3, D = 2 (diagnostic routine can catch).  
6. **Compute RPN** – 9 × 3 × 2 = 54.  
7. **Prioritize Actions** – Redundancy or predictive monitoring.  

## 3. Example FMEA Table for Lidar Module  

| # | Failure Mode | Effect on Safety | Severity (S) | Occurrence (O) | Detection (D) | RPN | Recommended Action |
|---|--------------|------------------|-------------|---------------|--------------|-----|--------------------|
| 1 | Sensor misalignment | Loss of accurate distance measurement → collision risk | 8 | 4 | 3 | 96 | Periodic calibration, alignment sensors |
| 2 | Power loss to lidar | Complete sensor blackout during operation | 9 | 5 | 2 | 90 | Dual power supplies, watchdog reboot |
| 3 | Software bug causing point cloud jitter | False obstacle detection → unnecessary braking | 4 | 6 | 5 | 120 | Runtime verification, redundancy with radar |

## 4. Integrating FMEA with ISO 26262  

- **ASIL Assignment**: Use the RPN to determine ASIL level for each failure mode; higher RPN typically leads to a higher ASIL.  
- **Safety Requirements Derivation**: Each high‑RPN failure mode translates into one or more safety requirements (e.g., “If lidar fails, vehicle must transition to safe state”).  
- **Traceability**: Link FMEA entries back to functional safety goals and verification artifacts.

## 5. Automation & Tool Support  

| Tool | Functionality |
|------|---------------|
| **Moldflow** | Predicts mechanical failures in sensor housings. |
| **Fault Tree Analysis (FTA) Software** | Visualizes causal relationships between failures. |
| **Safety Case Management Systems** | Central repository for FMEA data, traceability matrices. |

## 6. Tips for Effective AV FMEA  

1. **Cross‑disciplinary Teams** – Include hardware engineers, software developers, system integrators, and safety experts.  
2. **Dynamic Updates** – Re‑run FMEA when major architecture changes occur (e.g., adding a new sensor).  
3. **Real‑World Data Integration** – Use field‑data logs to refine occurrence probabilities.  

---