#### Steering & Suspension

The steering and suspension subsystems control vehicle dynamics, ride comfort, and safety. Modern autonomous vehicles employ sophisticated active or semi‑active mechanisms to optimize handling under varying conditions.

| Subsystem | Function | Typical Actuation Methods |
|-----------|----------|---------------------------|
| **Steering** | Translates driver/AI input into wheel angles. | Hydraulic rack & pinion, electric power steering (EPS), electro‑hydraulic steering. |
| **Suspension** | Absorbs road irregularities; maintains tire contact patch. | Passive springs/dampers, active suspension (electric actuators), semi‑active magnetorheological dampers. |

#### Steering Dynamics

- **Steering Ratio**: Relationship between steering wheel rotation and wheel angle.  
  - *Passive*: Fixed ratio; limited to driver input range.  
  - *EPS*: Variable ratio via gearboxes or servo motors, enabling “steer‑by‑wire” with torque sensing.
- **Torque Biasing**: Adjusts front/rear bias for improved stability during cornering.

#### Suspension Modeling

- **Quarter‑Car Model**: Simplifies dynamics to analyze vertical motion.  
- **Full Vehicle Dynamics**: Uses multi‑body simulation (MATLAB/Simulink, ADAMS) to optimize ride comfort and handling.

#### Actuator Technologies

| Type | Advantages | Disadvantages |
|------|------------|---------------|
| **Hydraulic** | High torque density; proven reliability. | Heavy, requires fluid maintenance. |
| **Electric (EPS)** | Precise control, regenerative capability, lighter weight. | Requires high‑voltage power supply. |
| **Magnetorheological Dampers** | Fast response (~ms), tunable damping in real time. | Complex control; higher cost. |

#### Control Loops

- **Steering Control**: Torque‑based control loop (desired torque → motor command) with position feedback from encoders.  
- **Suspension Control**: Closed‑loop force/velocity regulation using accelerometers and inertial sensors.

#### Safety & Standards

- **ISO 26262**: Functional safety for EPS (ASIL B/C).  
- **UNECE Regulation 5**: Vehicle dynamic control systems.  

#### Autonomous‑Specific Enhancements

1. **Predictive Steering** – Uses map data to anticipate upcoming turns and pre‑bias steering torque.  
2. **Active Roll Control** – Actuators counteract body roll during high‑speed maneuvers, improving stability.  
3. **Load‑Adaptive Suspension** – Adjusts damping based on payload distribution detected by onboard sensors.