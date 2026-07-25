#scRNA-seq and high-dimensional omics visualization. This template assumes you already have UMAP coordinates exported as a CSV.
library(readr)
library(dplyr)
library(ggplot2)

dir.create("figures", showWarnings = FALSE)

df <- read_csv("data/umap_data.csv", show_col_types = FALSE)

centers <- df %>%
  group_by(cluster) %>%
  summarise(
    UMAP_1 = median(UMAP_1),
    UMAP_2 = median(UMAP_2),
    .groups = "drop"
  )

p <- ggplot(df, aes(x = UMAP_1, y = UMAP_2, color = cluster)) +
  geom_point(size = 1.2, alpha = 0.8) +
  geom_text(
    data = centers,
    aes(label = cluster),
    color = "black",
    size = 4,
    fontface = "bold",
    show.legend = FALSE
  ) +
  labs(
    title = "UMAP Plot",
    x = "UMAP 1",
    y = "UMAP 2",
    color = "Cluster"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid = element_blank()
  )

ggsave("figures/umap_template.png", plot = p, width = 6.5, height = 5.5, dpi = 300)