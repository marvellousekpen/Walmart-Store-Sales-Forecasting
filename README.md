# Walmart-Store-Sales-Forecasting
https://github.com/marvellousekpen/Walmart-Store-Sales-Forecasting/blob/main/data-flow-animated.svg"
## INTRODUCTION
The objective of this analysis is to evaluate sales performance and identify various factors that influence it.

### PROBLEM STATEMENT

The Walmart’s Sales Strategy Manager needs clear insights into sales trends but struggles with complex reports and limited BI support. He aims to identify patterns, measure markdown effectiveness, and understand holiday sales impact to drive better decisions. Using SQL, this analysis will uncover key metrics:

-  Sales trends over time
-  Four-week moving average  
-  Percentage change in sales  
-  Sales breakdown by type  
-  Impact of markdowns, especially during holidays  
-  Performance distribution across store types  


### DATA SOURCE
The data is sourced from <a href="https://www.kaggle.com/datasets/gustavoserafim/walmart-recruiting-store-sales-forecasting-gsr">Kaggle</a>

### SKILLS/CONCEPTS DEMONSTRATED

- **Data Import & Integration:** Imported multiple CSV files into SQL using Python.  
- **SQL Querying & Optimization:** Utilized JOINS, CTEs, subqueries, and functions for in-depth analysis.  
- **Data Aggregation & Trend Analysis:** Applied aggregation techniques to uncover sales trends and performance insights.
  

### DATA IMPORTATION 
Imported multiple CSV files into SQL using Python. <a href="https://github.com/marvellousekpen/Walmart-Store-Sales-Forecasting/blob/main/Walmart.ipynb">View my Code</a>

### VALIDATION - CALCULATING THE POTENTIAL ROI
For this analysis, I included a breakdown of the calculations used to evaluate sales performance. Using SQL, I analyzed key metrics to assess the impact of markdowns and sales trends across Walmart stores.

This breakdown includes:

Calculating the 4-week moving average to smooth out sales trends over time.
Determining percentage change in sales to track growth or decline.
Analyzing markdown effectiveness by comparing sales before and after markdowns.
Evaluating holiday sales impact by comparing holiday vs. non-holiday sales.
Assessing performance distribution across store types to identify top-performing stores.
These calculations provide actionable insights into sales trends, markdown strategies, and store performance, helping optimize revenue and pricing strategies.

### PROJECT DONE
<a href="https://github.com/marvellousekpen/Walmart-Store-Sales-Forecasting/blob/main/walmart.sql">Project Code</a>

### INSIGHTS
- Sales show a fluctuating pattern over time, with significant peaks and dips, The sales peaked at $80,931,415.60 on December 24, 2010 while sales dropped to $41,358,514.41 on September 24, 2010.

- Sales spike dramatically during the holiday season (November and December), with increases of 45.86% in 2010-11-26 and 43.40% in 2011-11-25. However, sales drop significantly after the holiday season, with declines of -50.04% in 2010-12-31 and -40.20% in 2011-12-30.

- The percentage change in sales ranges extensively, ranging from -50.04% to +45.86%.

- Negative percentage changes are more frequent, indicating challenges in maintaining consistent sales growth outside of peak periods.

### Recommendations
- The sales trend data reveals significant opportunities during holiday periods and challenges during off-peak times. By leveraging seasonal trends, addressing low sales periods, and maintaining consistent marketing efforts, you can optimize sales performance and drive consistent growth. Implementing data-driven strategies and focusing on customer retention will help you adapt to changing market conditions and maximize revenue.

- Plan Robust marketing strategy, promotions, and inventory stocking around holiday periods (November and December) to capitalize on the high demand.

- Implement strategies to mitigate the sharp post-holiday sales decline, such as clearance sales or loyalty programs to retain customers.

- Investigate the root causes of sales declines during off-peak periods (e.g., lack of promotions, inventory issues, or external factors).

- Run targeted promotions or discounts during traditionally low-performing weeks to boost sales.

