---

# Hazard Analysis in Functional Safety of Autonomous Vehicles

> **Scope** – This page describes the two main methodologies used for *hazard analysis* under ISO 26262‑functional safety:  
> 1. **Failure Mode and Effects Analysis (FMEA)** – a structured, systematic approach to identifying potential failure modes of system components.  
> 2. **Hazard and Operability Study (HAZOP)** – a process‑centric technique that explores deviations from intended operation.

Both methods are complementary; in practice they are often combined into an *Integrated Hazard Analysis* that feeds the safety case for the vehicle’s safety‐critical software and hardware.

---

## 1. Failure Mode and Effects Analysis (FMEA)

### 1.1 Purpose
- Identify all plausible failure modes of a component or sub‑system.  
- Assess their potential effects on higher‑level functions, safety goals, and ultimately the *Safety Integrity Level* (ASIL).  
- Prioritize mitigation actions.

### 1.2 Process Steps

| Step | Description |
|------|-------------|
| **1. Define scope** | Determine boundaries: which component or function is being analysed (e.g., Lidar unit, braking control). |
| **2. Assemble team** | Cross‑disciplinary experts: hardware engineers, software developers, safety analysts, system integrators, and domain specialists. |
| **3. Identify failure modes** | List every plausible way the component can fail (e.g., “Lidar sensor returns null point cloud”, “Brake actuator stuck in ‘open’ state”). Use design documents, test logs, and expert intuition. |
| **4. Determine effects** | For each mode, describe *direct* and *indirect* consequences on vehicle operation, other components, and safety goals. |
| **5. Establish severity (S)** | Rate the seriousness of the effect on a 1–10 scale (ISO 26262: S‑1 = negligible; S‑9 = catastrophic). |
| **6. Assess occurrence (O)** | Estimate likelihood that the failure mode will occur, based on reliability data or historical evidence (O‑1 to O‑10). |
| **7. Evaluate detection (D)** | Determine how likely current safeguards will detect the failure before it causes harm (D‑1 to D‑10). |
| **8. Compute Risk Priority Number (RPN)** | `RPN = S × O × D`. Higher RPN indicates higher risk. |
| **9. Prioritize actions** | Select mitigation measures for high‑RPN items (redundancy, design changes, test procedures). |
| **10. Document & review** | Record all data in the *FMEA matrix* and perform periodic reviews as system evolves. |

### 1.3 Example – Lidar Failure

| # | Failure Mode | Effect | Severity (S) | Occurrence (O) | Detection (D) | RPN |
|---|--------------|--------|--------------|-----------------|---------------|-----|
| 1 | Lens contamination → loss of field‑of‑view | Vehicle cannot detect obstacles ahead | S‑8 | O‑4 | D‑6 | 192 |
| 2 | Electronics failure → complete sensor blackout | No distance data, collision risk | S‑9 | O‑3 | D‑5 | 135 |
| 3 | Software mis‑interpretation of point cloud | False obstacle detection (false positive) | S‑5 | O‑7 | D‑4 | 140 |

*Mitigation:* add redundant sensors (camera + radar), run health checks every 100 s, implement watchdog timers.

---

## 2. Hazard and Operability Study (HAZOP)

### 2.1 Purpose
- Systematically explore *process deviations* from intended operation.  
- Identify *hazards* that arise when a system deviates in unexpected ways.  
- Generate *recommendations* for safe‑by‑design controls.

### 2.2 Process Steps

| Step | Description |
|------|-------------|
| **1. Define the process** | For AVs, this could be “Obstacle avoidance” or “Lane keeping”. Break it into *nodes* (sub‑processes). |
| **2. Identify guide words** | Standard HAZOP guide words: *No*, *More*, *Less*, *As well as*, *Reverse*, *Other than*. |
| **3. Apply guide words to parameters** | For each node, apply every guide word to every process parameter (e.g., “speed”, “steering angle”). |
| **4. Identify deviations** | Record how the parameter could deviate (e.g., *More* speed → overshoot lane). |
| **5. Determine causes & hazards** | List potential root causes and resulting hazards (e.g., “sensor saturation” → loss of vehicle control). |
| **6. Assess safety significance** | Rate severity, exposure, and controllability. Map to ASIL if necessary. |
| **7. Recommend actions** | Controls, design changes, procedural mitigations. |
| **8. Document findings** | Produce a *HAZOP report* that feeds into the Safety Case. |

### 2.3 Example – Lane‑Keeping Node

| Guide Word | Parameter | Deviation | Root Cause | Hazard | Severity | Action |
|------------|-----------|-----------|------------|--------|----------|--------|
| No | Steering angle | 0° (no steering) | Power loss to actuator | Vehicle drifts off lane → collision | S‑9 | Redundant power supply, fail‑safe steering bias |
| More | Speed | > Target speed | Adaptive cruise control mis‑estimate | Overshoot lane boundaries | S‑7 | Speed limiter, additional braking logic |
| Reverse | Lane‑detection confidence | Negative value | Algorithm bug | Treat absence of lane as presence → wrong steering | S‑8 | Confidence threshold, fallback to radar |

---

## 3. Integrating FMEA & HAZOP

| Aspect | FMEA | HAZOP |
|--------|------|-------|
| Focus | *Component* failures | *Process* deviations |
| Output | RPN matrix | Hazard list + recommendations |
| Strength | Quantitative risk ranking | Systematic coverage of all parameter variations |
| Typical use | Early design review, component selection | Detailed safety analysis for complex behaviours |

**Workflow example:**

1. **FMEA first** – identify high‑risk failure modes in the *hardware* (e.g., Lidar).  
2. **HAZOP next** – analyze how those failures propagate through the *software* and control process (lane keeping, obstacle avoidance).  
3. **Cross‑check** – ensure that mitigation actions from FMEA are reflected in HAZOP controls.

---

## 4. Documentation & Traceability

| Item | Description |
|------|-------------|
| **Hazard Analysis Report (HAR)** | Consolidated view of all identified hazards, root causes, severity, and mitigations. |
| **FMEA Matrix** | Spreadsheet with columns: Failure Mode, Effect, S, O, D, RPN, Recommended Action. |
| **HAZOP Table** | Structured table as shown in the example. |
| **Safety Case (SC)** | Formal argument that all hazards are addressed to meet ASIL requirements; references FMEA and HAZOP artifacts. |

Traceability links each hazard back to a *Safety Goal* defined earlier in ISO 26262, ensuring that the entire safety lifecycle is covered.

---

## 5. Key Considerations for Autonomous Vehicles

1. **Dynamic Environment** – Unlike static industrial processes, AVs operate in constantly changing traffic scenarios; HAZOP must incorporate *scenario‑based deviations*.  
2. **Software‑Centric Failures** – Many hazards arise from software bugs or model mis‑specifications; FMEA should include *software failure modes* (e.g., “path planner outputs unreachable trajectory”).  
3. **Redundancy & Diversity** – Mitigation actions often involve multiple sensor modalities and diverse algorithms.  
4. **Data‑Driven Hazard Identification** – Use runtime monitoring data to refine FMEA/HAZOP over time (continuous safety case).  

---

## 6. References

1. ISO 26262-6:2018 – *Road vehicles – Functional Safety* – Part 6: *Safety Lifecycle*.  
2. SAE J3016 – *Taxonomy and Definitions for Automated Driving Systems*.  
3. IEEE Std 1228 – *Guidelines for Safety Analysis of Autonomous Vehicles*.  
4. Popp, A., et al. (2021). “A Unified FMEA‑HAZOP Framework for Connected Vehicles.” *SAE Technical Paper*.  

---

**End of page.**