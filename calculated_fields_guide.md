# 📊 Tableau Workbook Guide & Calculation Reference

This guide provides technical specifications for connecting Tableau Desktop to the dataset files, creating calculated fields, configuring Level of Detail (LOD) expressions, and assembling the two production dashboards.

---

## 1. Data Connection Architecture

1. Open **Tableau Desktop**.
2. Under **Connect** > **To a File**, select **Text file**.
3. Point to `data/country_performance_investment.csv`.
4. Add secondary connections or physical tables for:
   - `data/sports_summary.csv`
   - `data/regional_investment.csv`
   - `data/olympic_editions_timeline.csv`
   - `data/host_nation_performance.csv`
   - `data/regional_sport_distribution.csv`

---

## 2. Tableau Calculated Fields

### Calculation 1: Avg Medals per Athlete by Sport Category
* **Formula**:
  ```tableau
  SUM([Total_Medals]) / COUNTD([Athlete_ID])
  ```
* **Format**: Number (Custom), 3 Decimal Places.
* **Target Benchmark**: Rowing = `6.916`, Shooting = `6.731`.

### Calculation 2: Medal Efficiency Percentage
* **Formula**:
  ```tableau
  ([Total_Medals] / [Sports_Investment_USD_M]) * 100
  ```
* **Format**: Percentage, 2 Decimal Places.
* **Target Benchmark**: South America = `49.64%`, Europe/Asia = `45.98%`.

### Calculation 3: Cost per Podium Finish ($M per Medal)
* **Formula**:
  ```tableau
  IF SUM([Total_Medals]) > 0 THEN 
      SUM([Sports_Investment_USD_M]) / SUM([Total_Medals]) 
  ELSE 
      NULL 
  END
  ```
* **Format**: Currency (Standard / USD), 2 Decimal Places.

### Calculation 4: Host Nation Flag
* **Formula**:
  ```tableau
  IF [Country_Code] = [Host_Country_Code] THEN "Host Nation"
  ELSE "Visiting Nation"
  END
  ```

### Calculation 5: Strategic Efficiency Quadrant
* **Formula**:
  ```tableau
  IF [Medal_Efficiency_Pct] >= 50.0 AND [Sports_Investment_USD_M] < 50.0 THEN
      "High Efficiency / Lean Budget (e.g. Slovakia, Georgia, Ethiopia)"
  ELSEIF [Total_Medals] >= 500 THEN
      "Global Powerhouse (e.g. USA, China)"
  ELSE
      "Standard Allocation"
  END
  ```

---

## 3. Dashboard Assemblies

### Dashboard 1: Olympic Performance & Athlete Participation Trends
* **Resolution**: 1440 x 900 px (Fixed)
* **Sheet 1**: `Avg Medals per Athlete by Sport` (Horizontal Bar, sorted descending)
* **Sheet 2**: `Global Performance Metrics by Country` (Ranked Bar, USA = 735, China = 696)
* **Sheet 3**: `Trend of Medals Awarded Over Years` (Line Chart, 2000 low = 305, 2020 peak = 363, 2026 = 334)

### Dashboard 2: Olympic Performance & Regional Efficiency
* **Resolution**: 1440 x 900 px (Fixed)
* **Sheet 1**: `Investment vs Medal Performance` (Bubble Chart, X: Spend, Y: Medals, Size: Efficiency)
* **Sheet 2**: `Regional Efficiency Percentage` (Donut / Pie, South America = 49.64%)
* **Sheet 3**: `Comparing Medal Totals Across Olympic Hosts` (Bar, Japan = 105, USA = 100, China = 93)
