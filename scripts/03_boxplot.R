library(readr)
library(dplyr)
library(ggplot2)

dir.create("figures", showWarnings = FALSE)

df <- read_csv("data/boxplot_data.csv", show_col_types = FALSE)

p <- ggplot(df, aes(x = group, y = value, fill = group)) +
  geom_boxplot(width = 0.65, alpha = 0.85, outlier.shape = NA) +
  geom_jitter(width = 0.12, size = 2, alpha = 0.7) +
  scale_fill_manual(values = c(
    "Control" = "#4C78A8",
    "Treatment" = "#E45756"
  )) +
  labs(
    title = "Grouped Boxplot",
    x = NULL,
    y = "Measured value"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )

ggsave("figures/boxplot_template.png", plot = p, width = 6, height = 5, dpi = 300)