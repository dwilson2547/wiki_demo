# Functional Safety in Autonomous Vehicles  

Functional safety is a cornerstone for any automotive system that can influence the safety of vehicle occupants and other road users. The International Organization for Standardization’s ISO 26262 standard provides a systematic framework for identifying hazards, assessing risks, assigning safety integrity levels (ASIL), and implementing mitigations throughout the development life‑cycle.

## 1. Scope  

- Applies to all hardware and software that directly or indirectly influences vehicle operation.  
- Covers everything from powertrain controls to driver‑monitoring cameras.  
- Extends across design, implementation, verification, validation, production, and decommissioning stages.

## 2. Key Concepts  

| Term | Definition |
|------|------------|
| **Hazard** | Any event or condition that can cause harm. |
| **Risk** | Probability of a hazard occurring multiplied by the severity of its consequence. |
| **ASIL** | Safety Integrity Level (A–D) indicating required safety rigor; D is highest, A lowest. |
| **Functional Safety Management (FSM)** | Governance structure ensuring continuous compliance with ISO 26262. |
| **Safety Lifecycle** | Phases: concept, system, hardware/software, production & operation. |

## 3. Hazard Identification Methods  

### 3.1 Failure Mode and Effects Analysis (FMEA)  
- Structured approach to identify potential failure modes of components or processes.  
- Assigns Severity (S), Occurrence (O), Detectability (D) ratings → calculates Risk Priority Number (RPN = S×O×D).  

**Typical FMEA Workflow:**

1. **Define scope & boundaries.**  
2. **List component functions.**  
3. **Identify failure modes.**  
4. **Determine effects on safety.**  
5. **Assign S, O, D values (usually 1–10).**  
6. **Calculate RPN and prioritize actions.**  

### 3.2 Hazard Analysis and Risk Assessment (HARA)  
- Formal ISO 26262 step preceding FMEA.  
- Determines severity classes (S0–S4), exposure levels (E0–E4), and controllability (C0–C4).  
- Produces **Risk Classification Matrix** that maps to ASIL.

### 3.3 Hazard Analysis using Failure Mode, Effects, and Criticality Analysis (FMECA)  
- Extends FMEA by adding criticality assessment: how many safety requirements a failure mode violates.  

## 4. ASIL Determination  

| Severity | Exposure | Controllability | ASIL |
|----------|----------|-----------------|------|
| S4       | E3–E4    | C0–C1           | D    |
| S3       | E2–E4    | C0–C1           | C/D  |
| S2       | E1–E4    | C0–C1           | B/C  |
| S1       | E0–E4    | C0–C1           | A/B  |

- **S**: Harm severity (e.g., fatal, severe).  
- **E**: Likelihood of exposure.  
- **C**: Ability to control or mitigate the hazard.  

### Example ASIL Assignment Process

1. Identify a hazard: *Loss of steering angle sensor* → S3.  
2. Estimate exposure: *Occurs during high‑speed turns* → E4.  
3. Assess controllability: *Driver cannot detect loss in real time* → C0.  
4. Map to ASIL D.  

## 5. Safety Requirements Lifecycle  

1. **System Level** – Derive safety goals from HARA.  
2. **Hardware Level** – Design for redundancy, fault‑tolerant components.  
3. **Software Level** – Partition into safe (critical) and non‑safe domains; use MISRA‑C/ MISRA‑C++ guidelines.  
4. **Verification & Validation** – Static analysis, unit testing, integration testing, hardware‑in‑the‑loop (HIL).  

## 6. Key ISO 26262 Sections for AVs  

- **Part 1:** Vocabulary, definitions.  
- **Part 2:** Management of functional safety.  
- **Part 3:** Concept phase – HARA, safety goals.  
- **Part 4:** System level – architecture, safety constraints.  
- **Part 5:** Hardware design – reliability analysis.  
- **Part 6:** Software design – coding standards, verification.  
- **Part 7:** Production and operation – quality management.  

## 7. Common Challenges in Autonomous Vehicles  

| Challenge | Mitigation |
|-----------|------------|
| Complex sensor fusion → increased failure modes | Modular architecture, fail‑safe defaults (e.g., “drive to a safe state”). |
| Machine learning components | Use of explainable AI, bounded inference, formal verification of control logic. |
| Dynamic environments | Continuous re‑planning, real‑time safety monitoring, fallback strategies. |

## 8. Glossary  

- **ASIL** – Safety Integrity Level.  
- **HARA** – Hazard Analysis and Risk Assessment.  
- **FMEA** – Failure Mode and Effects Analysis.  
- **S4** – Fatal injury or death.  
- **E3** – Likely to occur under normal operating conditions.  

---

# Functional Safety Standards: ISO 26262 Overview  

ISO 26262 is the automotive functional safety standard that defines a framework for ensuring safety throughout the life‑cycle of an automotive system, from concept through decommissioning. It extends IEC 61508 to the automotive domain and introduces automotive‑specific concepts such as ASIL levels.

## 1. Structure of ISO 26262  

| Part | Content |
|------|---------|
| **Part 1** | Vocabulary & definitions |
| **Part 2** | Management of functional safety |
| **Part 3** | Concept phase – HARA, safety goals |
| **Part 4** | System level – architecture, safety constraints |
| **Part 5** | Hardware design – reliability, fault tolerance |
| **Part 6** | Software design – coding standards, verification |
| **Part 7** | Production & operation – quality management |
| **Part 8** | Supporting processes (e.g., training) |

## 2. Key Processes  

1. **Safety Management**  
   - Establish a safety plan.  
   - Assign responsibilities for safety functions.  

2. **Concept Phase**  
   - Conduct HARA to determine ASIL.  
   - Define safety goals and constraints.  

3. **System Design**  
   - Create system architecture that satisfies safety goals.  
   - Partition into safe & non‑safe domains.

4. **Hardware/Software Development**  
   - Apply appropriate safety mechanisms (redundancy, watchdogs).  
   - Follow coding guidelines (MISRA-C, MISRA-C++).

5. **Verification & Validation**  
   - Static analysis, unit tests, integration tests, system tests, HIL, and functional safety test reports.

6. **Production & Operation**  
   - Ensure that production processes maintain safety integrity.  
   - Implement maintenance plans for long‑term safety.

## 3. ASIL Levels Explained  

| Level | Required Safety Rigor | Typical Mitigations |
|-------|----------------------|---------------------|
| **ASIL D** | Highest | Dual redundant controllers, hardware fault detection, extensive testing (≥1 000 hrs). |
| **ASIL C** | High | Redundant subsystems, watchdog timers, formal verification of safety logic. |
| **ASIL B** | Medium | Software redundancy, error‑correcting codes on communication buses. |
| **ASIL A** | Low | Basic fault detection, conventional testing. |

## 4. Safety Goals vs Functional Requirements  

- **Safety Goal:** *“The vehicle must not collide with a pedestrian under any circumstances.”*  
- **Functional Requirement:** *“Activate emergency braking when obstacle distance < 2 m and velocity > 5 km/h.”*  

Safety goals are abstract, system‑wide constraints. Functional requirements are concrete actions that fulfill those goals.

## 5. Common Pitfalls & How to Avoid Them  

| Pitfall | Description | Prevention |
|---------|-------------|------------|
| **Underestimating ASIL** | Misclassifying hazards → insufficient safety measures | Rigorous HARA, peer reviews |
| **Inconsistent Documentation** | Missing traceability between goals and implementation | Use a Safety Case Manager tool |
| **Neglecting Non‑Functional Requirements** | Performance or reliability issues undermining safety | Integrate NFRs into the safety case |

## 6. Integration with Autonomous Vehicle Development  

- **Sensor Fusion Modules:** Treat each sensor type as an independent source; apply redundancy at both hardware (e.g., dual Lidar) and software levels.  
- **Machine‑Learning Controllers:** Use *bounded* models, continuous monitoring of inference confidence, fallback to rule‑based control on anomaly detection.  
- **Software Partitioning:** Isolate safety‑critical code in a separate partition with stricter timing constraints and watchdog supervision.

## 7. Documentation Templates  

1. **Hazard Analysis Report** – lists hazards, severity, exposure, controllability, ASIL.  
2. **Safety Goal Specification** – links each goal to its ASIL.  
3. **Functional Safety Concept** – architecture diagram with safety constraints.  
4. **Verification Matrix** – traceability of tests to requirements and goals.  

---

