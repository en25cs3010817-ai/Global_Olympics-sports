# 🏅 Global Olympic Sports Performance Analysis (1992–2026)

[![Tableau](https://img.shields.io/badge/Tableau-2024.1+-E97627?style=flat&logo=tableau&logoColor=white)](https://www.tableau.com/)
[![HTML5](https://img.shields.io/badge/HTML5-TailwindCSS%20%7C%20Chart.js-38B2AC?style=flat&logo=html5&logoColor=white)](https://tailwindcss.com/)
[![Dataset](https://img.shields.io/badge/Data-1992--2026%20(60%20NOCs%2C%2050%20Sports)-blue?style=flat&logo=databricks&logoColor=white)](#dataset-architecture)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An end-to-end data analytics and visual storytelling suite analyzing global Olympic performance, athlete yield, sports investment efficiency, and host nation advantage across Summer and Winter Games from **1992 to 2026**.

---

## 🎯 Executive Overview

Analyzing factors behind Olympic success across 34 years of historical data reveals how sporting infrastructure, funding allocation, and athlete development programs convert into podium finishes. This project delivers actionable business intelligence across three primary decision-maker scenarios:

1. **Ms. Priya (NOC Performance Strategist)**: Identifies high-yield disciplines (e.g., Rowing at 6.916 medals/athlete, Shooting at 6.731) and benchmarks national performance against powerhouses (USA: 735 medals, China: 696 medals).
2. **Mr. Carlos (Sports Investment Analyst)**: Pinpoints cost-efficiency outliers (Slovakia, Georgia, Ethiopia) and guides regional grant distributions (South America leading global efficiency at 49.64%).
3. **William Robert (Broadcast Data Storyteller)**: Visualizes the "Host Nation Bump" (Japan with 105 home medals, USA with 100, China with 93) and historical medal volume swings (trough of 305 in 2000 to peak of 363 in 2020).

---

## 📁 Repository Structure

```plaintext
olympic_analytics/
├── data/                                    # Cleaned, standardized Olympic datasets (1992–2026)
│   ├── country_performance_investment.csv   # 60 NOCs: medals, athlete counts, budgets ($M), efficiency %
│   ├── host_nation_performance.csv          # Host nation medal hauls across Summer & Winter editions
│   ├── olympic_editions_timeline.csv        # Historical timeline (1992–2026) with medal volume swings
│   ├── regional_investment.csv              # Regional aggregation & investment efficiency benchmarks
│   ├── regional_sport_distribution.csv      # Sport-wise medal distribution across geographic zones
│   └── sports_summary.csv                   # 50 sports categories: athlete counts & per-athlete medal yield
├── web/
│   └── index.html                           # Standalone interactive dashboard (Tailwind CSS + Chart.js)
├── tableau/                                 # Tableau workbook documentation & calculated field specs
├── scripts/                                 # Data cleaning, normalization, and export scripts
└── README.md                                # Project documentation
```

---

## 👥 Scenario Deep Dives

### Scenario 1: Ms. Priya — NOC Performance Strategist
* **Goal**: Optimize national sporting investment and athlete squad selection ahead of upcoming Olympic cycles.
* **Key Findings**:
  - **High-Yield Sports**: **Rowing (6.916 medals/athlete)** and **Shooting (6.731 medals/athlete)** produce the highest return per accredited athlete.
  - **Global Benchmark**: Contextualizes performance against the **United States (735 medals)** and **China (696 medals)**.
* **Strategy**: Shift funds toward concentrated technical categories with multiple medal events rather than spreading budget thinly over low-conversion disciplines.

### Scenario 2: Mr. Carlos — International Development Fund Analyst
* **Goal**: Maximize the marginal productivity of international sports grants and aid packages.
* **Key Findings**:
  - **Overperforming Nations**: **Slovakia**, **Georgia**, and **Ethiopia** achieve outsized medal success despite modest annual budgets ($22M–$28M).
  - **Regional Efficiency**: **South America leads global efficiency at 49.64%**, followed by **Europe/Asia at 45.98%**.
* **Strategy**: Rebalance funding models away from gross medal tallies in favor of structural efficiency ratios to seed underfunded, high-potential federations.

### Scenario 3: William Robert — Broadcast Data Storyteller
* **Goal**: Build data-backed narratives for global sports broadcasts and documentary features.
* **Key Findings**:
  - **Host Nation Advantage**: **Japan** led home performances with **105 medals**, followed by the **United States (100)** and **China (93)**.
  - **Timeline Dynamics**: Historical medal awards swung from a low of **305 in 2000** to a peak of **363 in 2020**, stabilizing at **334 in 2026**.
* **Strategy**: Produce feature broadcast segments around the "Home Advantage Phenomenon" and the geopolitical evolution of Olympic medal distributions.

---

## 📊 Tableau Specifications & Calculated Fields

### Calculated Fields Syntax

```tableau
// 1. Avg Medals per Athlete by Sport Category
SUM([Total_Medals]) / COUNTD([Athlete_ID])

// 2. Regional Medal Efficiency Percentage
([Total_Medals] / [Sports_Investment_USD_M]) * 100

// 3. Host Nation Status
IF [Country_Code] = [Host_Country_Code] THEN "Host Nation"
ELSE "Visiting Nation"
END

// 4. Investment per Medal (Cost per Podium)
IF SUM([Total_Medals]) > 0 THEN
    SUM([Sports_Investment_USD_M]) / SUM([Total_Medals])
ELSE
    NULL
END
```

---

## 🌐 Interactive Web Dashboard & GitHub Pages Deployment

The repository includes a standalone, zero-dependency interactive dashboard (`web/index.html`) featuring interactive Chart.js visualizations, scenario filtering, metric cards, and data tables.

### How to Enable Live Web Preview via GitHub Pages:
1. In your GitHub repository, navigate to **Settings** > **Pages**.
2. Under **Build and deployment** > **Source**, select `Deploy from a branch`.
3. Choose branch: `main` (or `master`) and folder: `/ (root)` or `/web`.
4. Click **Save**. Within 1–2 minutes, your interactive dashboard will be live at:
   `https://<your-username>.github.io/<your-repo-name>/web/`

### Running Locally:
Simply open `web/index.html` in any modern web browser or run:
```bash
# Using Python
python -m http.server 8000
# Then visit http://localhost:8000/web/
```

---

## 📈 Benchmark Data Summary

| Category / Metric | Top Performer / Peak | Second | Third |
| :--- | :--- | :--- | :--- |
| **All-Time Medals (1992–2026)** | 🇺🇸 United States (735) | 🇨🇳 China (696) | 🇷🇺 / ROC (420) |
| **Avg Medals per Athlete** | 🚣 Rowing (6.916) | 🎯 Shooting (6.731) | 🛶 Canoeing & Kayak (6.240) |
| **Regional Medal Efficiency** | 🌎 South America (49.64%) | 🌍 Europe/Asia (45.98%) | 🌎 North America (39.62%) |
| **Host Nation Podium Haul** | 🇯🇵 Japan (105) | 🇺🇸 United States (100) | 🇨🇳 China (93) |
| **Total Medals Timeline** | 🥇 2020 Tokyo (363) | 🥈 2026 Milano (334) | 🥉 2000 Sydney (305 - trough) |

---

## 📜 License
This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
