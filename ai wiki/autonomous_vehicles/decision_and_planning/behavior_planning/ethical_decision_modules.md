# Ethical Decision Modules in Autonomous Vehicles  

**Purpose** – Equip behavioral planners with mechanisms to evaluate and resolve morally relevant trade‑offs while maintaining compliance with legal and safety constraints.

---

## 1. Moral Dimensions of AV Behavior  

| Dimension | Example Scenario |
|-----------|------------------|
| **Utilitarian Harm Minimization** | Choosing the action that results in least expected casualties. |
| **Rights & Duties** | Balancing driver’s right to safe travel against pedestrian rights. |
| **Fairness** | Avoiding discriminatory treatment of different road users (e.g., preferentially yielding to certain vehicle types). |

---

## 2. Ethical Decision Frameworks  

### 2.1 Rule‑Based Ethics Engine  

*Define hard constraints:*  
- `never_hit_child`  
- `yield_to_pedestrians_at_crosswalk`

These are evaluated before any ML policy; if violated, the system overrides the action.

### 2.2 Utilitarian Cost Model  

```
cost = Σ_i (probability_of_harm_i * severity_i)
```

The planner selects the action with minimal cost while respecting safety constraints.

### 2.3 Preference Aggregation via Human Feedback  

*Method:*  
- Collect crowd‑sourced ratings on hypothetical scenarios.  
- Train a preference model P(action | scenario) using Bayesian inference.  
- Use this model to bias policy selection toward socially acceptable actions.

---

## 3. Integration into the Planning Stack  

1. **Perception** → Generate candidate trajectories with associated risk metrics.  
2. **Ethical Module** → Evaluate each trajectory’s moral cost; assign a utility score.  
3. **Decision Engine** → Choose highest‑utility, safety‑compliant trajectory.  
4. **Motion Planner** → Refine selected trajectory for kinematic feasibility.

---

## 4. Implementation Example  

```pseudo
FOR each candidate_trajectory:
    risk_pedestrian = estimate_collision_probability(pedestrians)
    risk_occupant   = estimate_collision_probability(occupants)

    util_cost = weight_ped * risk_pedestrian + weight_occ * risk_occupant

    IF util_cost < safety_threshold AND respects_rules(candidate_trajectory):
        SELECT candidate_trajectory
        BREAK
```

*Weights (`weight_ped`, `weight_occ`) can be tuned to reflect societal values or regulatory mandates.*

---

## 5. Regulatory & Governance Considerations  

| Requirement | Implementation |
|-------------|----------------|
| **Auditability** | Log decision rationale (rule hits, cost calculations). |
| **Public Transparency** | Publish ethical policy documents and rationale behind weight settings. |
| **Legal Liability** | Define liability sharing between manufacturer, software provider, and operator based on decision module outcomes. |

---

## 6. Ongoing Research Topics  

* Multi‑agent ethical coordination (e.g., platooning).  
* Dynamic adjustment of ethical weights based on context (night vs day, weather).  
* Cross‑cultural studies to capture varying moral norms.

---

**References**  

1. Lin, P., et al. “Robot Ethics: The Ethical Decision-Making Process for Autonomous Vehicles.” *Journal of Field Robotics*, 2015.  
2. Shalev-Shwartz, S., et al. “The Ethics of Autonomous Driving – A Multi‑Perspective Review.” *Nature Machine Intelligence*, 2021.  

---  