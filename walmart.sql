--Sale Trend --
SELECT Date, SUM(Weekly_Sales)::NUMERIC(10,2) AS Total_sales
FROM train 
GROUP BY Date
ORDER BY Date;


---4 Weeks Moving Average Of Sales.
WITH Sales_Per_Week AS (
    SELECT
        Date,
        SUM(weekly_Sales)::NUMERIC AS Total_sales
    FROM 
        train
    GROUP BY 
        Date
)
SELECT
    Date,
    Total_sales::NUMERIC(16, 2) AS Total_sales,
    ROUND(AVG(Total_sales) OVER (ORDER BY Date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS Moving_Avg_4_Weeks
FROM 
    Sales_Per_Week
ORDER BY 
    Date;


--Percentage Change In Sales
SELECT 
    Date, 
    SUM(Weekly_Sales)::NUMERIC(10,2) AS Total_sales,
    LAG(SUM(Weekly_Sales)) OVER (ORDER BY Date) AS Previous_Day_Sales,
    ROUND(
        (SUM(Weekly_Sales)::NUMERIC - LAG(SUM(Weekly_Sales)) OVER (ORDER BY Date)::NUMERIC) / 
        NULLIF(LAG(SUM(Weekly_Sales)) OVER (ORDER BY Date)::NUMERIC, 0) * 100, 2
    ) AS Sales_Percentage_Change
FROM train 
GROUP BY Date
ORDER BY Date;


--Sales By Type
SELECT s.type, TO_CHAR(t.Date::DATE, 'YYYY-MM') AS Month,  SUM(t.Weekly_Sales) AS Total_sales
FROM train t
JOIN stores  s
USING(Store)
GROUP BY s.type, Month
ORDER BY Month;

--Creating a temp table for the impact of markdowns on sales--
CREATE TEMP TABLE joined_data AS
SELECT 
    t.store,
    t.dept,
    t.date,
    t.weekly_sales,
    f.markdown1,
    f.markdown2,
    f.markdown3,
    f.markdown4,
    f.markdown5,
    f.isholiday
FROM 
    train t
JOIN 
    features f 
ON 
    t.store = f.store AND t.date = f.date;
	
--the Impact of Markdowns on Sales
SELECT 
	CORR(weekly_sales, markdown1)::NUMERIC(10, 2) AS markdown1_corr,
	CORR(weekly_sales, markdown2)::NUMERIC(10, 2) AS markdown2_corr,
	CORR(weekly_sales, markdown3)::NUMERIC(10, 2) AS markdown3_corr,
	CORR(weekly_sales, markdown4)::NUMERIC(10, 2) AS markdown4_corr,
	CORR(weekly_sales, markdown5)::NUMERIC(10, 2) AS markdown5_corr
FROM
	joined_data;

--Markdown Effectiveness During Holidays
SELECT 
	isholiday,
	AVG(weekly_sales)::NUMERIC(10, 2) AS avg_sales,
	AVG(markdown1)::NUMERIC(10, 2) AS avg_markdown1,
	AVG(markdown2)::NUMERIC(10, 2) AS avg_markdown2,
	AVG(markdown3)::NUMERIC(10, 2) AS avg_markdown3,
	AVG(markdown4)::NUMERIC(10, 2) AS avg_markdown4,
	AVG(markdown5)::NUMERIC(10, 2) AS avg_markdown5
FROM
	joined_data
GROUP BY
	isholiday;
	

--Holiday Impact Analysis BY Store:
SELECT 
	store,
	AVG(CASE WHEN isholiday = true THEN weekly_sales END)::NUMERIC(10, 2) AS holiday_sales,
	AVG(CASE WHEN isholiday = false THEN weekly_sales END)::NUMERIC(10, 2) AS regular_sales
FROM
	joined_data
GROUP BY 
	store
ORDER BY 
	store;

--Store Type Performance 
SELECT 
	s.type,
	COUNT(CASE
	   WHEN t.weekly_sales > 10000 THEN 'High'
	   WHEN t.weekly_sales > 5000 THEN 'Medium'
	   ELSE 'Low'
	End) AS performance_category 
FROM train t
JOIN stores s ON t.store = s.store
Group by s.type;


--Performance Distribution For Each Store Type
WITH categorized_sales AS (
    SELECT 
        s.type,
        CASE 
            WHEN t.weekly_sales > 10000 THEN 'High'
            WHEN t.weekly_sales > 5000 THEN 'Medium'
            ELSE 'Low'
        END as performance_category,
        COUNT(*) as category_count
    FROM train t
    JOIN stores s ON t.store = s.store
    GROUP BY s.type,
        CASE 
            WHEN t.weekly_sales > 10000 THEN 'High'
            WHEN t.weekly_sales > 5000 THEN 'Medium'
            ELSE 'Low'
        END
)
SELECT 
    type,
    performance_category,
    category_count,
    ROUND((category_count::NUMERIC / SUM(category_count) OVER (PARTITION BY type)) * 100) as percentage
FROM categorized_sales
ORDER BY type, performance_category;

--ROI
--Calculate Total Revenue (Sales after Markdowns)
WITH Sales_With_Markdowns AS (
    SELECT 
        t.store,
        t.date,
        SUM(t.weekly_sales)::NUMERIC AS total_sales,
        COALESCE(SUM(f.markdown1 + f.markdown2 + f.markdown3 + f.markdown4 + f.markdown5), 0)::NUMERIC AS total_markdowns
    FROM train t
    JOIN features f ON t.store = f.store AND t.date = f.date
    GROUP BY t.store, t.date
)

-- Calculate Net Profit and ROI
SELECT 
    s.store,
    s.total_sales,
    s.total_markdowns,
    (s.total_sales - s.total_markdowns) AS net_profit,
    CASE 
        WHEN s.total_markdowns = 0 THEN 0  -- If total_markdowns is 0, set ROI to 0
        ELSE ROUND(((s.total_sales - s.total_markdowns) / s.total_markdowns)::NUMERIC, 2) 
    END AS roi_percentage
FROM Sales_With_Markdowns s
ORDER BY s.store;

