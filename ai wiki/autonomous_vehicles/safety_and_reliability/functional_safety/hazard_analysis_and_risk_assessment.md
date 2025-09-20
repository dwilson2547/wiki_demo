# Hazard Analysis and Risk Assessment (HARA) for Autonomous Vehicles  

Hazard Analysis and Risk Assessment (HARA) is the ISO 26262 mandated step that identifies hazards, evaluates their severity, exposure, and controllability, and assigns an appropriate Safety Integrity Level (ASIL). HARA sets the foundation for all subsequent safety activities.

## 1. HARA Workflow  

1. **Hazard Identification** – Enumerate potential hazardous events (e.g., “Loss of braking control during autonomous mode”).  
2. **Assign Severity (S)** – Rate from S0 (no injury) to S4 (fatal).  
3. **Determine Exposure (E)** – Likelihood of encountering the hazard under normal operating conditions: E0 (unlikely) to E4 (likely).  
4. **Assess Controllability (C)** – Driver’s ability to avoid or mitigate the hazard: C0 (no control) to C4 (full control).  
5. **Populate Risk Classification Matrix** – Map S, E, C to ASIL.  

## 2. Severity Classes  

| Class | Definition | Example |
|-------|------------|---------|
| **S0** | No injury or negligible harm | Minor software glitch that does not affect safety |
| **S1** | Non‑life‑threatening injury | Temporary loss of lane keeping at low speed |
| **S2** | Life‑threatening injury | Hard braking without warning leading to rear‑end collision |
| **S3** | Severe injury or fatality | Loss of steering during highway driving |
| **S4** | Fatality | Vehicle collides with a pedestrian |

## 3. Exposure Levels  

| Level | Probability | Example Context |
|-------|-------------|-----------------|
| **E0** | Extremely unlikely | A specific sensor failure only in a very rare environment |
| **E1** | Rare | Occurs once per 10,000 km under normal driving |
| **E2** | Unlikely | Once per 1,000 km, typical urban traffic |
| **E3** | Likely | Several times per 100 km in mixed traffic |
| **E4** | Very likely | Happens frequently during daily commute |

## 4. Controllability Classes  

| Class | Driver’s Ability | Example |
|-------|------------------|---------|
| **C0** | No control | Vehicle stalls mid‑lane without warning |
| **C1** | Limited control | Sudden loss of steering; driver can react but may not avoid collision |
| **C2** | Moderate control | Minor brake failure; driver can apply manual brakes with delay |
| **C3** | High control | Software glitch causing minor speed variation; driver can compensate easily |
| **C4** | Full control | No hazard present |

## 5. Risk Classification Matrix (Excerpt)  

| Severity \ Exposure | E0 | E1 | E2 | E3 | E4 |
|---------------------|----|----|----|----|----|
| **S4** | D  | D  | D  | D  | D  |
| **S3** | C/D | C  | C  | C  | C  |
| **S2** | B/C | B  | B  | B  | B  |
| **S1** | A/B | A  | A  | A  | A  |
| **S0** | N/A | N/A | N/A | N/A | N/A |

- *N/A* indicates that hazards with S0 are not safety critical.  
- The ASIL column denotes the minimum required integrity level for the hazard.

## 6. Example HARA Entry  

| Hazard ID | Description | Severity (S) | Exposure (E) | Controllability (C) | ASIL |
|-----------|-------------|--------------|--------------|---------------------|------|
| HAZ-001 | Autonomous braking system fails to engage when obstacle detected | S3 | E4 | C0 | D |
| HAZ-002 | Lidar returns noisy data leading to false obstacle detection | S2 | E3 | C1 | C |
| HAZ-003 | Software crash in trajectory planner during high‑speed maneuver | S4 | E2 | C0 | D |

## 7. Documentation & Traceability  

- **Hazard Log** – Central repository for all hazards and their assigned ASILs.  
- **Safety Goal Document** – Each hazard translates into one or more safety goals (e.g., “The vehicle shall not collide with obstacles when autonomous braking is active”).  
- **Requirement Trace Matrix** – Links safety goals to system, hardware, and software requirements.  

## 8. Re‑assessment Frequency  

- Conduct HARA at the beginning of each major development phase.  
- Re‑evaluate after significant architectural changes (e.g., adding a new sensor or switching from rule‑based to ML control).  

---