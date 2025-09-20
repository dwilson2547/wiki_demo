# Real‑Time Task Scheduling for Autonomous Vehicles  

Real‑time scheduling guarantees that safety‑critical tasks meet deterministic deadlines. Two principal scheduling models dominate: **Fixed‑Priority Preemptive (FP)** and **Earliest Deadline First (EDF)**.

## 1. Fixed‑Priority Preemptive (FP)

### Rate Monotonic Scheduling (RMS)  
- Assigns higher priority to tasks with shorter periods.  
- Proven schedulability for periodic, independent tasks under RMS constraints:  
  \[
  U = \sum_{i=1}^{n} \frac{C_i}{T_i} \le n(2^{1/n}-1)
  \]
  where \(C_i\) is worst‑case execution time and \(T_i\) the period.

### Deadline Monotonic Scheduling (DMS)  
- Uses relative deadlines instead of periods, useful when deadlines differ from periods.

### Implementation Tips  
- **Priority Inheritance**: Prevent priority inversion by temporarily raising lower‑priority task’s priority.  
- **Static Analysis**: Tools like `RTA` (Rate‑Monotonic Analysis) help verify schedulability.

## 2. Earliest Deadline First (EDF)

### Dynamic Priority Scheduling  
- At run time, the task with the nearest deadline gets highest priority.  
- Optimal for single‑processor systems: schedulable if total utilization \(U \le 1\).

### Practical Constraints  
- Requires accurate task timing and low overhead context switches.  
- Hard to integrate with legacy fixed‑priority code.

## 3. Multi‑Processor Scheduling

| Approach | Characteristics |
|----------|------------------|
| Partitioned EDF | Assign tasks statically to cores; each core runs EDF independently. |
| Global EDF | All tasks share a global priority queue; more flexible but higher overhead. |

### Real‑Time Operating Systems (RTOS) Support  
- **FreeRTOS+TCP**: Offers preemptive scheduling with configurable priorities.  
- **VxWorks**: Commercial RTOS with advanced scheduling policies and safety certifications.

## 4. Timing Analysis & Verification  

1. **Worst‑Case Execution Time (WCET)** Estimation  
   - Use static analysis tools (e.g., aiT, OTAWA) to bound execution times.  
2. **Schedulability Analysis**  
   - Apply RMS/EDF bounds or simulation‑based approaches for complex task graphs.  
3. **Runtime Monitoring**  
   - Detect deadline misses and trigger fail‑safe modes.

## 5. Safety‑Critical Considerations  

- **Deterministic I/O**: Ensure sensor acquisition and actuator commands have bounded latency.  
- **Redundancy**: Run critical tasks on multiple cores with independent code paths (e.g., dual‑threaded fault detection).  
- **Graceful Degradation**: If a deadline miss occurs, switch to a safe state rather than continue unsafe operation.

---