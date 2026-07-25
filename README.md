# Publication Figure Pack

This repository provides a reproducible R-based workflow for creating publication-ready scientific figures. It is designed as a portfolio asset and client-facing starter pack for manuscript figures, reports, presentations, and other research outputs that need clear, polished visual communication.

The current starter pack includes reusable scripts for:
- ComplexHeatmap heatmaps
- volcano plots
- grouped boxplots
- multi-panel figure assembly

## Repository Purpose

This repository is intended to demonstrate:
- reproducible scientific figure generation,
- clean and consistent visual style,
- reusable plotting workflows in R,
- and a client-ready figure-delivery structure.

## What This Repo Shows

The repo is built to show how a figure pack can be organized in a professional way:
- scripts are separated by figure type,
- demo data is kept separate from code,
- outputs are written to a dedicated figures folder,
- and the project can be extended for different omics or research contexts.

## Included Figure Types

- ComplexHeatmap heatmap for matrix-style data.
- Volcano plot for differential analysis summaries.
- Grouped boxplot for simple comparisons.
- Multi-panel publication-style layout for combining multiple figures into one panel.

## Repository Structure

```text
publication-figure-pack/
├── README.md
├── .gitignore
├── environment.yml
├── data/
│   └── demo_data.csv
├── figures/
├── scripts/
│   ├── 01_heatmap.R
│   ├── 02_volcano_plot.R
│   ├── 03_boxplot.R
│   ├── 04_multi_panel_figure.R
│   └── utils.R
└── docs/
    └── figure-overview.md
```

## Usage

1. Create the R environment from `environment.yml`.
2. Open the scripts in R or RStudio.
3. Run the script for the figure type you want.
4. Outputs will be saved in the `figures/` directory.

Example:

```r
source("scripts/02_volcano_plot.R")
```

## Intended Use

This repository can be adapted for:
- RNA-seq figure packs,
- scRNA-seq figure packs,
- variant analysis summaries,
- methylation visualizations,
- and general scientific reporting.

## Portfolio Value

This repo is meant to show that I can deliver more than raw analysis. It demonstrates figure design, reproducibility, and the ability to turn biological data into clear, publication-ready visuals.

## Notes

- This is a starter repository and can be extended with additional figure templates.
- The structure is intentionally simple so it can be reused across projects.
- The same framework can support both internal reports and manuscript-ready output.