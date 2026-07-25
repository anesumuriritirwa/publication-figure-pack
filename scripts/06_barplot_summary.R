#This gives you a summary barplot template for counts, proportions, or pathway/category summaries.
library(readr)
library(dplyr)
library(ggplot2)

dir.create("figures", showWarnings = FALSE)

df <- read_csv("data/barplot_data.csv", show_col_types = FALSE)

p <- ggplot(df, aes(x = category, y = value, fill = category)) +
  geom_col(width = 0.7, alpha = 0.9) +
  geom_text(aes(label = value), vjust = -0.4, size = 3.8) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Summary Barplot",
    x = NULL,
    y = "Value"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "none",
    axis.text.x = element_text(angle = 25, hjust = 1)
  )

ggsave("figures/barplot_template.png", plot = p, width = 7, height = 5, dpi = 300)
