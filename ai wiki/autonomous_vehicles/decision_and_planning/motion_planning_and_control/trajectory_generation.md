**Trajectory Generation in Autonomous Vehicles**  

*Purpose:*  A trajectory generator computes a smooth, feasible path that guides the vehicle from its current state toward a desired goal while respecting kinematic limits, dynamic constraints, and environmental obstacles.

---

### 1. Core Objectives
| Objective | Description |
|-----------|-------------|
| **Feasibility** | Trajectory must satisfy vehicle dynamics (e.g., steering limits, acceleration bounds). |
| **Optimality** | Minimizes a cost function: travel time, energy consumption, passenger comfort, or risk. |
| **Safety** | Maintains safe separation from static and dynamic obstacles. |
| **Robustness** | Handles sensor noise, model uncertainty, and disturbances. |

### 2. Typical Pipeline
1. **Goal Specification** – Desired waypoint, lane‑change target, or high‑level behavior command.  
2. **Obstacle Map Integration** – HD map data + real‑time detections fused into a cost field.  
3. **Initial Path Guess** – Short‑term heuristic (e.g., straight line, Dubins path).  
4. **Trajectory Optimization** – Refine using spline or MPC methods.  
5. **Feasibility Check** – Verify against dynamics; replan if infeasible.  

### 3. Key Algorithms
| Algorithm | Strengths | Weaknesses |
|-----------|-----------|------------|
| **B‑Spline / Polynomial Trajectories** | Smooth, easily differentiable; low computational load | Requires careful handling of constraints; global optimization needed for complex scenes |
| **Model Predictive Control (MPC)** | Handles multi‑constraint problems online; can incorporate dynamic models | Computationally intensive; requires linearization or convexification |
| **Rapidly-exploring Random Trees (RRT*)** | Good for high‑dimensional spaces; asymptotically optimal | Non‑deterministic; may produce jagged paths |
| **Dynamic Window Approach (DWA)** | Real‑time local planning with velocity sampling | Limited horizon; may not be globally optimal |

### 4. Common Cost Functions
- **Path Length**: \(J_{\text{len}} = \int_0^T \|\dot{\mathbf{x}}\|\,dt\)
- **Curvature Penalty**: \(J_{\kappa} = \int_0^T \kappa(t)^2 dt\) (promotes comfort)
- **Obstacle Cost**: \(J_{\text{obs}} = \sum_{i}\phi(\|\mathbf{x}-\mathbf{o}_i\|)\), where \(\phi\) is a barrier function
- **Control Effort**: \(J_u = \int_0^T u(t)^2 dt\)

### 5. Implementation Tips
- Use *warm starts* (previous trajectory) to reduce solve time in MPC.  
- Discretize the horizon finely enough to capture curvature changes but coarsely for speed.  
- Cache linearized dynamics matrices if vehicle model changes slowly.  

---

**References**

1. S. Thrun et al., *Probabilistic Robotics*, MIT Press, 2005.  
2. J. Zico Kolter & D. Cox, “Learning to Drive with Deep Reinforcement Learning,” *ICRA*, 2014.  
3. R. E. Bagnell & A. Y. Ng, “A Survey of Inverse Reinforcement Learning”, *JMLR*, 2004.