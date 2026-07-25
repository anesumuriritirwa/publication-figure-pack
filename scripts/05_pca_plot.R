library(readr)
library(dplyr)
library(ggplot2)
library(tibble)

dir.create("figures", showWarnings = FALSE)

expr <- read_csv("data/pca_matrix.csv", show_col_types = FALSE)
meta <- read_csv("data/pca_metadata.csv", show_col_types = FALSE)

mat <- expr %>%
  column_to_rownames("feature") %>%
  as.matrix()

pca <- prcomp(t(mat), scale. = TRUE)

scores <- as.data.frame(pca$x[, 1:2]) %>%
  tibble::rownames_to_column("sample") %>%
  left_join(meta, by = "sample")

var_explained <- summary(pca)$importance[2, 1:2] * 100

p <- ggplot(scores, aes(x = PC1, y = PC2, color = group)) +
  geom_point(size = 3.5, alpha = 0.9) +
  stat_ellipse(aes(fill = group), geom = "polygon", alpha = 0.15, color = NA, show.legend = FALSE) +
  scale_color_manual(values = c("Control" = "#4C78A8", "Treatment" = "#E45756")) +
  scale_fill_manual(values = c("Control" = "#4C78A8", "Treatment" = "#E45756")) +
  labs(
    title = "PCA Plot",
    x = paste0("PC1 (", round(var_explained[1], 1), "%)"),
    y = paste0("PC2 (", round(var_explained[2], 1), "%)")
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.title = element_blank()
  )

ggsave("figures/pca_template.png", plot = p, width = 6.5, height = 5.5, dpi = 300)