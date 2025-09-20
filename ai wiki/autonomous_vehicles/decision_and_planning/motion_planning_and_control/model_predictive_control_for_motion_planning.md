**Model Predictive Control (MPC) for Motion Planning**  

*MPC* is a control strategy that solves an optimization problem at each time step over a finite prediction horizon, producing an optimal sequence of control inputs subject to dynamic constraints and safety requirements.

---

### 1. MPC Formulation

| Symbol | Meaning |
|--------|---------|
| \(\mathbf{x}_k\) | State vector (position, heading, velocity, etc.) at discrete time \(k\). |
| \(\mathbf{u}_k\) | Control input vector (steering angle, acceleration) at time \(k\). |
| \(f(\cdot)\) | Vehicle dynamics model. |
| \(h(\cdot)\) | Constraint mapping (obstacle avoidance, actuation limits). |

**Optimization Problem**

\[
\begin{aligned}
\min_{\{\mathbf{u}_0,\dots,\mathbf{u}_{N-1}\}} \quad & 
& J = \sum_{k=0}^{N-1} \ell(\mathbf{x}_k,\mathbf{u}_k) + \ell_f(\mathbf{x}_N)\\
\text{s.t.} \quad &
& \mathbf{x}_{k+1}=f(\mathbf{x}_k,\mathbf{u}_k), \\
&& h_{\text{ineq}}(\mathbf{x}_k,\mathbf{u}_k)\le 0, \\
&& h_{\text{eq}}(\mathbf{x}_k,\mathbf{u}_k)=0.
\end{aligned}
\]

- **Stage cost** \(\ell\) penalizes deviation from desired trajectory and control effort.  
- **Terminal cost** \(\ell_f\) encourages stability at horizon end.  

### 2. Vehicle Dynamics Models

| Model | Complexity | Typical Use |
|-------|------------|-------------|
| *Kinematic Bicycle* | Low | Urban driving, moderate speeds |
| *Dynamic Bicycle* | Medium | High‑speed cornering, traction control |
| *Full Rigid Body* | High | Heavy‑load or high‑precision tasks |

Linearization around a nominal trajectory yields:
\[
\delta \mathbf{x}_{k+1} = A_k \delta \mathbf{x}_k + B_k \delta \mathbf{u}_k
\]
where \(A_k, B_k\) are Jacobians.

### 3. Constraints

| Type | Example |
|------|---------|
| **Actuation Limits** | \(|\delta_{\text{steer}}|\leq \delta_{\max}\), \(|a|\leq a_{\max}\) |
| **Dynamic Feasibility** | Slip angle limits, tire forces |
| **Obstacle Avoidance** | \(\|\mathbf{x}_k - \mathbf{o}_i\|\geq r_{\text{safe}}\) (soft penalty via barrier functions) |
| **Road Geometry** | Lane centerline constraint, curvature bounds |

### 4. Solvers & Real‑time Implementation

- **Quadratic Programming (QP)**: When dynamics are linear and cost is quadratic; fast solvers like OSQP or qpOASES.  
- **Nonlinear Programming (NLP)**: For nonlinear dynamics; use interior‑point methods (e.g., IPOPT).  
- **Sequential Quadratic Programming (SQP)**: Iteratively solves QPs approximating the NLP.  

**Speed‑up Techniques**

1. *Warm start* with previous solution.  
2. *Model reduction*: Use simplified dynamics during low‑risk phases.  
3. *Parallelization*: Distribute horizon segments across cores.  
4. *Explicit MPC*: Precompute control law offline for a discretized state space (memory intensive).  

### 5. Practical Considerations

- **Horizon Length**: Typically 1–2 s; longer horizons improve optimality but increase computation.  
- **Sampling Time**: 10–20 ms on modern CPUs; adjust horizon accordingly.  
- **Safety Nets**: Fall back to a simple controller (PID) if MPC fails to converge within budget.

### 6. Case Study – Urban Intersection

| Step | Action |
|------|--------|
| 1 | Detect stop sign and cross‑traffic via perception. |
| 2 | Generate desired waypoint at intersection exit lane center. |
| 3 | Formulate MPC with obstacle constraints for oncoming vehicles. |
| 4 | Solve; apply first control input, replan each cycle. |

---

**References**

- J. Maciejowski, *Predictive Control: Past, Present and Future*, Springer, 2002.  
- A. Bemporad et al., “A Tutorial on MPC for Automotive Applications,” *IEEE Intelligent Vehicles Symposium*, 2018.