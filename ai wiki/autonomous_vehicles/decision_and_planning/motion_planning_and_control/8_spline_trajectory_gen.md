**B‑Spline Trajectory Generation for Autonomous Vehicles**  

*B‑splines* provide a compact, smooth representation of a trajectory using control points and basis functions, making them suitable for offline path planning or as an initial guess for MPC.

---

### 1. Mathematical Background

A *degree‑\(d\)* B‑spline curve \(\mathbf{p}(t)\) is defined over a knot vector \(T = \{t_0,\dots,t_{n+d+1}\}\):

\[
\mathbf{p}(t)=\sum_{i=0}^{n} N_{i,d}(t)\,\mathbf{P}_i
\]

- \(\mathbf{P}_i\): control points.  
- \(N_{i,d}(t)\): B‑spline basis functions (defined recursively).  

**Properties**

- **Local Control**: Moving a single control point only affects the curve in its support interval.  
- **Cⁿ Continuity**: A degree‑\(d\) spline is \(C^{d-1}\) continuous, ensuring smooth curvature transitions.  
- **Convex Hull**: The curve lies within the convex hull of its control points (useful for collision checking).  

### 2. Trajectory Generation Workflow

1. **Waypoint Extraction** – Obtain a sequence of waypoints \(\{\mathbf{w}_k\}\) from high‑level planner.  
2. **Knot Vector Design** – Uniform or chord‑length parameterization to distribute control points evenly.  
3. **Control Point Optimization** – Solve for \(\mathbf{P}_i\) minimizing a cost function (e.g., deviation from waypoints, curvature penalty).  
4. **Constraint Enforcement** – Apply bounds on curvature, acceleration by adding inequality constraints during optimization.  

### 3. Cost Function Example

\[
J = \sum_{k}\|\mathbf{p}(t_k)-\mathbf{w}_k\|^2
+ \lambda_{\kappa}\int_0^1 \|\kappa(t)\|^2 dt
+ \lambda_u\int_0^1 \|\dot{\mathbf{u}}(t)\|^2 dt
\]

- **Waypoint Fidelity** – Ensures the spline tracks desired points.  
- **Curvature Penalty** – Promotes comfort and dynamic feasibility.  
- **Control Effort** – Keeps steering changes smooth.

### 4. Handling Constraints

| Constraint | Implementation |
|------------|----------------|
| **Velocity/Acceleration Limits** | Add inequality constraints on first/second derivatives of \(\mathbf{p}(t)\). |
| **Obstacle Avoidance** | Enforce that the convex hull of control points stays outside inflated obstacle polygons. |
| **Lane Centerline** | Add penalty terms for deviation from lane center or impose hard bounds on lateral offset. |

### 5. Real‑time Considerations

- B‑splines are *offline* by nature; however, they can be regenerated quickly if high‑level goals change (few hundred milliseconds).  
- Use *warm starts*: reuse previous control points as initial guess for optimization.  
- For dynamic replanning, employ *dynamic time warping* to adjust existing spline parameters.

### 6. Integration with MPC

1. **Initial Guess** – Feed B‑spline coefficients into MPC as the nominal trajectory.  
2. **Constraint Relaxation** – Allow MPC to refine local deviations while preserving global smoothness.  

---

**References**

- T. Kim & S. M. Lee, “Trajectory Generation Using B-splines for Autonomous Driving,” *IEEE Intelligent Transportation Systems Magazine*, 2017.  
- P. J. Van den Berg et al., “A Survey of Short‑Term Planning Algorithms for Mobile Robots,” *Robotics: Science and Systems*, 2008.