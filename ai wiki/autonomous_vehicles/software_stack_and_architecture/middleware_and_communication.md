# Middleware & Communication in Autonomous Vehicles  

Middleware is the glue that connects heterogeneous software components (perception, planning, control) across multiple ECUs and processors. The dominant middleware paradigms are **Data Distribution Service (DDS)**‑based publish/subscribe systems and **Message‑oriented middleware** such as ROS 2 or custom CAN‑based buses.

## 1. Data Distribution Service (DDS)

### Core Concepts  
- **Topic**: Named data stream with a defined data type.  
- **Publisher / Subscriber**: Entities that produce or consume topics.  
- **Quality of Service (QoS)**: Fine‑grained controls over reliability, durability, deadline, latency budget, etc.

### DDS Profiles for AVs  
| QoS | Description | Typical Use |
|-----|-------------|--------------|
| Reliability (BestEffort / Reliable) | Guarantees data delivery or accepts occasional loss. | Sensor streams vs control commands |
| Deadline | Maximum acceptable interval between successive samples. | Real‑time safety messages |
| Latency Budget | Upper bound on end‑to‑end latency. | High‑frequency vehicle dynamics updates |
| Durability (Volatile / Transient) | Persistence of data across publisher restarts. | HD map data caching |

### Implementation Examples  
- **RTI Connext**: Commercial DDS implementation with extensive safety certifications.  
- **OpenSplice**: Open source, widely used in research.  
- **Fast RTPS (eProsima)**: Lightweight, suitable for embedded systems.

## 2. ROS 2 Middleware Layer  

ROS 2 abstracts DDS behind a generic API, allowing developers to swap underlying implementations without changing application code. Key advantages include:

- **Composable Nodes**: Run multiple ROS nodes in the same process, reducing inter‑process overhead.  
- **Dynamic Reconfiguration**: Adjust QoS at runtime via `rqt` or command line tools.  
- **Tooling Ecosystem**: Visualization (`rviz2`, `rqt_graph`) and debugging (`ros2 topic echo`, `ros2 param set`).

## 3. CAN‑based Communication  

### Classic CAN (CAN FD)  
- Used for low‑level vehicle control messages (steering, braking).  
- **Message IDs**: Priority encoded in identifier; lower numeric ID = higher priority.  

### Flexible Data‑Rate (FD) Enhancements  
- Supports up to 64 bytes per frame, improving data throughput for diagnostic and infotainment traffic.

## 4. V2X Communication

Vehicle-to-Everything (V2X) protocols such as **C‑V2X** or **DSRC** rely on dedicated short‑range communications:

- **Message Types**: Cooperative Awareness Messages (CAM), Decentralized Environmental Notification Messages (DENM).  
- **Latency Requirements**: <10 ms for safety‑critical exchanges.  

## 5. Security Considerations

| Threat | Mitigation |
|--------|------------|
| Message spoofing | Cryptographic authentication (e.g., X.509 certificates) |
| Replay attacks | Sequence numbers and timestamps |
| Denial of Service | Rate limiting, QoS throttling |

---