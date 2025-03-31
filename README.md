# 📊 Bank of America Credit Card Marketing Strategy – Segmentation Analysis

## 🧠 Project Objective

This project analyzes credit card usage data from Bank of America to identify customer segments using unsupervised learning techniques. The segmentation allows BOA to:

- Target elite customers with premium offers
- Engage low-activity customers
- Control credit risk by flagging high-risk usage patterns

---

## 📁 Dataset Overview

- 📄 File: `BOA.csv`
- 📊 Records: 8950 credit card users
- 📈 Variables: Credit balance, cash advances, purchases, tenure, limits, payments

---

## 🔍 Methodology

### 1️⃣ Data Preprocessing
- Removed identifiers
- Scaled numeric variables
- Visualized distributions

### 2️⃣ Clustering Techniques
| Method | Tool | Purpose |
|--------|------|---------|
| Hierarchical Clustering | `hclust()` + `daisy()` | To build tree-based clusters |
| K-Means Clustering | `kmeans()` + PCA | To optimize cluster separation |
| Model-Based Clustering | `Mclust()` | To allow elliptical cluster shapes |
| Latent Class Analysis | `poLCA()` | For discrete behavioral segments |

---

## 📊 Visuals

| Plot | Purpose |
|------|---------|
| Histogram of PURCHASES | Highlights skewed spending patterns |
| Dendrogram | Tree view of customer similarity |
| PCA Cluster Plot | Visualizes separation in K-means |
| Mclust Cluster Plot | Finite mixture model summary |
| LCA Clusters | 3-class and 4-class segmentation

---

## 🧠 Key Findings

- **Cluster 5**: High purchase frequency, low risk → Premium offer segment
- **Cluster 6**: Cash advance heavy, minimal purchases → Financial stress
- **Cluster 1**: Low spending but consistent payments → Loyalty-focused campaigns
- **Cluster 3–4**: Mid-spending behavior with repayment delays → Educate & incentivize

---

## 💼 Business Strategy

- 🎯 **Targeting**: Reward low-risk, high-value clusters
- 🚫 **Risk Mitigation**: Flag cash-heavy clusters for debt counseling
- 📈 **Revenue Growth**: Tailor promotions to maximize activation and engagement

---

## 🧪 Technologies Used

- R (`cluster`, `mclust`, `ggplot2`, `poLCA`)
- PCA & LCA for customer behavioral profiling

---

## 📁 Folder Structure

- `boa_analysis.R`: Full code
- `datasets/BOA.csv`: Credit card data
- `screenshots/`: All plots

---



[LinkedIn – Praneth Nandeesh](https://www.linkedin.com/in/praneth-nandeesh-789038285)


