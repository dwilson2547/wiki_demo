# Dynamic Re‑Planning in Autonomous Vehicles  

**Objective**  
Dynamic re‑planning allows an autonomous vehicle to adapt its high‑level route in response to changing traffic conditions, incidents, or environmental factors while ensuring safety and comfort.

---

## Triggers for Dynamic Re‑Planning

| Trigger | Description |
|---|---|
| **Traffic Congestion** | Significant increase in travel time on a planned edge. |
| **Accidents / Incidents** | Reported collision or stalled vehicle blocking lanes. |
| **Roadwork / Temporary Closures** | Construction zones that render segments unusable. |
| **Sensor‑Based Obstruction** | Real‑time detection of unexpected obstacles (e.g., large debris). |
| **Policy Updates** | New speed limits, temporary detours announced by authorities. |

---

## Re‑Planning Architecture

```
+------------------+          +--------------------+
|  Monitoring Unit | --TRIG--> | Dynamic Planner    |
+------------------+          +--------------------+
                                    |
                                    v
                          +-----------------+
                          | Route Optimizer |
                          +-----------------+
                                    |
                                    v
                         +---------------------+
                         | Waypoint Generator |
                         +---------------------+
```

1. **Monitoring Unit**  
   * Continuously ingests traffic APIs, incident feeds, and perception alerts.  

2. **Dynamic Planner**  
   * Determines whether a re‑plan is required based on thresholds (e.g., 30 % increase in travel time).  

3. **Route Optimizer**  
   * Executes incremental graph search (D* Lite, Lifelong Planning A\*) to find an alternative path.  

4. **Waypoint Generator**  
   * Translates the new route into a sequence of waypoints for the behavior planner.

---

## Incremental Graph Search Algorithms

| Algorithm | Complexity | Suitability |
|---|---|---|
| **D* Lite** | O(|E| log |V|) per update | Handles small local changes efficiently. |
| **Lifelong Planning A\*** | Similar to D* Lite | Good for large maps with frequent updates. |
| **A\*** (re‑run) | O(|E| log |V|) | Simpler but less efficient for incremental changes. |

---

## Decision Logic

1. **Minor Detour**  
   * If only a single edge is affected, adjust that segment and keep the rest of the route unchanged.

2. **Full Re‑Route**  
   * When multiple edges or a large portion of the path becomes unusable, recompute from current pose to destination.

3. **Safety Margin**  
   * Ensure new route respects safety buffers (e.g., avoid lanes with heavy construction).

4. **Comfort Considerations**  
   * Penalize routes that require abrupt lane changes or high curvature.

---

## Smooth Transition Strategies

| Strategy | How It Works |
|---|---|
| **Waypoint Blending** | Interpolate between old and new waypoint sets over a short horizon. |
| **Trajectory Re‑Optimization** | Re‑plan low‑level trajectory to accommodate the updated waypoints while maintaining current velocity profile. |
| **Driver Notification (if manual mode)** | Display detour information on HUD or infotainment system. |

---

## Evaluation Metrics

| Metric | Target |
|---|---|
| **Re‑Planning Latency** | < 200 ms for incremental updates. |
| **Detour Length Increase** | ≤ 5% over the optimal static route. |
| **Safety Compliance** | Zero violations of lane restrictions or speed limits post re‑plan. |

---

## Security & Resilience

- **Authenticated Traffic Feeds**: Use signed APIs to prevent spoofed incident reports.  
- **Fail‑Safe Defaults**: If map data is inconsistent, fall back to conservative detour (e.g., go straight ahead).  
- **Redundancy**: Maintain multiple traffic data sources (roadside units, cellular, satellite).

---

## Research & Development Opportunities

1. **Predictive Re‑Planning** – Anticipate congestion using machine learning models and preemptively adjust routes.  
2. **Cooperative Re‑Planning** – Share route plans with nearby vehicles to coordinate detours.  
3. **Learning‑Based Cost Functions** – Adjust cost weights based on real‑world driving data (e.g., driver comfort scores).

---

*End of Dynamic Re‑Planning page.*  

@PAGEEND