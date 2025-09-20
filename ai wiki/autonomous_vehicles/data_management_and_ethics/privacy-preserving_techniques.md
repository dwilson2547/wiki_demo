# Privacy‑Preserving Techniques in AV Data Handling  

**Goal**  
Protect individuals’ privacy while still enabling the training of high‑performance perception models. This page surveys state‑of‑the‑art techniques that can be applied at various stages of the data pipeline.

---

## 1. Federated Learning (FL)  

| Feature | Description |
|---------|-------------|
| **Decentralized training** | Models are trained locally on vehicles; only gradients or model updates are sent to a central server. |
| **Privacy guarantees** | Raw sensor data never leaves the vehicle; sensitive information is implicitly protected. |
| **Challenges** | Communication overhead, stragglers, non‑IID data distribution. |

### 1.1 FL Variants  
* **Horizontal FL** – Vehicles share similar model architectures but different data samples.  
* **Vertical FL** – Different vehicles contribute complementary features for the same set of instances.  

---

## 2. Differential Privacy (DP)  

| Concept | Implementation |
|---------|----------------|
| **ε‑Differential privacy** | Adds calibrated noise to training gradients or inference outputs. |
| **Privacy budget** | Tracks cumulative privacy loss across multiple queries. |

### 2.1 Practical Steps  
* **Gradient clipping** – Bound the norm of each gradient before aggregation.  
* **Noise addition** – Gaussian mechanism with σ proportional to the clip bound and desired ε.  
* **DP‑SGD** – Integrate DP into stochastic gradient descent; libraries: Opacus (PyTorch), TensorFlow Privacy.

---

## 3. Homomorphic Encryption (HE)  

| Property | Benefit |
|----------|---------|
| **Encrypted computation** | Operations on ciphertexts yield encrypted results that decrypt to the same as if performed on plaintext. |

### 3.1 Use Cases  
* **Inference in the cloud** – Vehicles upload encrypted feature vectors; server processes them without decryption.  
* **Model updates** – Gradient updates can be encrypted before transmission.

> *Note:* Current HE schemes are computationally expensive; practical deployments rely on lightweight partially homomorphic encryption for specific operations (e.g., dot products).

---

## 4. Secure Multi‑Party Computation (SMPC)  

| Scenario | How it works |
|----------|--------------|
| **Collaborative training** | Multiple parties jointly compute a function over their inputs while keeping them private. |

### 4.1 Protocols  
* **Secret sharing** – Split data into shares distributed among servers; reconstruct only when needed.  
* **Yao’s garbled circuits** – Efficient for Boolean operations; extended to arithmetic circuits.

---

## 5. Edge‑to‑Edge Privacy  

| Layer | Technique |
|-------|-----------|
| **On‑board inference** | Deploy models locally; no data leaves the vehicle. |
| **Selective logging** | Store only aggregated statistics (e.g., counts of detected objects) instead of raw sensor streams. |

---

## 6. Data Anonymization & Redaction  

* **Image blurring** – Apply Gaussian blur to faces or license plates using face‑detection APIs.  
* **Synthetic data generation** – Replace real pedestrians with procedurally generated avatars (GANs).  

> *Trade‑off:* Over‑blurring can reduce model performance; balance privacy and utility.

---

## 7. Regulatory Alignment  

| Regulation | Privacy Technique |
|------------|-------------------|
| GDPR Article 5(1)(f) – Purpose limitation | Federated learning, on‑board inference |
| CCPA Section 1798.140 – Data minimization | Edge logging, selective retention |
| ISO/IEC 27001 | Secure data storage and access controls |

---

## 8. Implementation Checklist  

| Step | Action | Tool / Library |
|------|--------|----------------|
| 1 | Define privacy budget (ε) | Opacus, TensorFlow Privacy |
| 2 | Integrate DP‑SGD into training pipeline | PyTorch + Opacus |
| 3 | Deploy federated learning server | Flower, TFF |
| 4 | Perform periodic audit of data flows | SIEM tools (Splunk, ELK) |
| 5 | Document privacy impact assessment (PIA) | NIST SP 800‑30 |

---

**References**  
1. Dwork, C., & Roth, A. (2014). The Algorithmic Foundations of Differential Privacy.  
2. McMahan et al. (2017). Communication-Efficient Learning of Deep Networks from Decentralized Data.  
3. Bonawitz et al. (2019). Towards Federated Learning at Scale: System Design.  
