library(cluster)   # For daisy and clustering plots
library(mclust)    # For model-based clustering
library(poLCA)     # For latent class analysis (categorical data)

#  Load the data
boa_data <- read.csv("~/Downloads/BOA.csv")

#  Remove the first two columns (X and CUST_ID)
boa_data <- boa_data[, -c(1, 2)]

#  Scaling numeric variables
numeric_columns <- sapply(boa_data, is.numeric)  # Identify numeric columns
boa_data_scaled <- boa_data
boa_data_scaled[, numeric_columns] <- scale(boa_data[, numeric_columns])

# Visualize PURCHASES using a histogram
ggplot(boa_data, aes(x = PURCHASES)) +
  geom_histogram(binwidth = 500, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of PURCHASES", x = "PURCHASES Amount", y = "Frequency") +
  theme_minimal()

#  cluster summarization function
seg.summ <- function(data, groups) {
  aggregate(data, list(Group = groups), function(x) mean(as.numeric(x), na.rm = TRUE))
}

#  Hierarchical Clustering
boa_dist <- daisy(boa_data_scaled)  # Compute distance matrix for mixed data types
boa_hc <- hclust(boa_dist, method = "complete")  # Hierarchical clustering
plot(boa_hc, main = "Dendrogram of BOA Data", xlab = "", sub = "")
rect.hclust(boa_hc, k = 8, border = "red")  # Cut tree into 4 clusters
boa_hc_clusters <- cutree(boa_hc, k = 8)  # Cluster memberships
table(boa_hc_clusters)
hc_summary <- seg.summ(boa_data_scaled, boa_hc_clusters)
print(hc_summary)

#  K-means Clustering
set.seed(1234)  # For reproducibility
boa_kmeans <- kmeans(boa_data_scaled, centers = 6, nstart = 25)  # K-means with multiple starts
table(boa_kmeans$cluster)
kmeans_summary <- seg.summ(boa_data_scaled, boa_kmeans$cluster)
print(kmeans_summary)

#  Visualize K-means Clusters Using PCA
library(ggplot2)
pca <- prcomp(boa_data_scaled[, numeric_columns])
pca_data <- data.frame(pca$x[, 1:2], Cluster = as.factor(boa_kmeans$cluster))
ggplot(pca_data, aes(PC1, PC2, color = Cluster)) +
  geom_point(size = 2) +
  ggtitle("PCA Plot of K-means Clusters") +
  theme_minimal()

#  Model-based Clustering (Mclust)
boa_mclust <- Mclust(boa_data_scaled, G = 6)  # Fit with 1 to 4 clusters
summary(boa_mclust)
clusplot(boa_data_scaled, boa_mclust$class, color = TRUE, shade = TRUE, 
         labels = 4, lines = 0, main = "Model-based Cluster Plot")
mclust_summary <- seg.summ(boa_data_scaled, boa_mclust$class)
print(mclust_summary)

#  Data for Latent Class Analysis (poLCA)
boa_data_cut <- boa_data  # Work with unscaled data for poLCA
boa_data_cut$BALANCE <- cut(boa_data$BALANCE, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
boa_data_cut$PURCHASES <- cut(boa_data$PURCHASES, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
boa_data_cut$CREDIT_LIMIT <- cut(boa_data$CREDIT_LIMIT, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))

seg.f <- with(boa_data_cut, cbind(BALANCE, PURCHASES, CREDIT_LIMIT) ~ 1)

# Step 10: Latent Class Analysis
set.seed(123)
boa_LCA3 <- poLCA(seg.f, data = boa_data_cut, nclass = 3)  # 3 classes
boa_LCA4 <- poLCA(seg.f, data = boa_data_cut, nclass = 4)  # 4 classes

# Compare LCA Models
boa_LCA3$bic
boa_LCA4$bic

# Summarize LCA Results
lca3_summary <- seg.summ(boa_data, boa_LCA3$predclass)
print(lca3_summary)
lca4_summary <- seg.summ(boa_data, boa_LCA4$predclass)
print(lca4_summary)

# Visualize LCA Clusters
clusplot(boa_data_cut, boa_LCA3$predclass, color = TRUE, shade = TRUE, 
         labels = 4, lines = 0, main = "LCA Plot (k=3)")
clusplot(boa_data_cut, boa_LCA4$predclass, color = TRUE, shade = TRUE, 
         labels = 4, lines = 0, main = "LCA Plot (k=4)")

