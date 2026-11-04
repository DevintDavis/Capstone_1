
-- ============================================================
-- EmporiUm | Capstone 1: Business Analysis with SQL and Excel
-- Analyst: Devin Davis
-- Assigned sales territory: North Carolina Online Sales
-- Region: South (North Carolina, South Carolina, Florida, Texas)
-- Database: sample_sales (MySQL)
-- ============================================================

-- QUESTION 1: Total revenue and date range for the assigned territory
SELECT
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(SalesTotal), 2) AS Total_Revenue,
    MIN(`Date`) AS Start_Date,
    MAX(`Date`) AS End_Date
FROM sample_sales.Online_Sales
WHERE ShiptoState = 'North Carolina';

-- QUESTION 2: Revenue breakdown by year and month
SELECT
    YEAR(`Date`) AS Sales_Year,
    MONTH(`Date`) AS Sales_Month,
    ROUND(SUM(SalesTotal), 2) AS Monthly_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState = 'North Carolina'
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY Sales_Year, Sales_Month;

-- QUESTION 3: Compare North Carolina with its South Region
-- The South Region state list follows the territory mapping
-- used in this analysis; confirm against instructor assignment.
SELECT
    ROUND(SUM(CASE WHEN ShiptoState = 'North Carolina'
                   THEN SalesTotal ELSE 0 END), 2) AS North_Carolina_Revenue,
    ROUND(SUM(SalesTotal), 2) AS South_Region_Revenue,
    ROUND(100.0 * SUM(CASE WHEN ShiptoState = 'North Carolina'
                           THEN SalesTotal ELSE 0 END)
          / NULLIF(SUM(SalesTotal), 0), 2) AS NC_Percent_of_Region
FROM sample_sales.Online_Sales
WHERE ShiptoState IN ('North Carolina', 'South Carolina', 'Florida', 'Texas');

-- QUESTION 4: Monthly transaction count and average transaction
-- amount by product category for North Carolina online sales
SELECT
    YEAR(o.`Date`) AS Sales_Year,
    MONTH(o.`Date`) AS Sales_Month,
    c.Category,
    COUNT(*) AS Transaction_Count,
    ROUND(AVG(o.SalesTotal), 2) AS Average_Transaction,
    ROUND(SUM(o.SalesTotal), 2) AS Total_Revenue
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina'
GROUP BY YEAR(o.`Date`), MONTH(o.`Date`), c.Category
ORDER BY Sales_Year, Sales_Month, c.Category;

-- Supporting analysis for the Excel category PivotChart:
-- total transactions and revenue by product category
SELECT
    c.Category,
    COUNT(*) AS Sales_Rows,
    ROUND(SUM(o.SalesTotal), 2) AS Total_Revenue
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina'
GROUP BY c.Category
ORDER BY Total_Revenue DESC;

-- QUESTION 5: Rank online sales performance by state in the South Region
-- This ranking provides regional context; North Carolina is
-- the assigned territory being evaluated.
SELECT
    ShiptoState AS State,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(SalesTotal), 2) AS Total_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState IN ('North Carolina', 'South Carolina', 'Florida', 'Texas')
GROUP BY ShiptoState
ORDER BY Total_Revenue DESC;

-- VALIDATION: Confirm product/category joins preserve NC sales totals.
-- Expected from previous results: 386 sales rows and $346,285.31.
-- Compare the following result with the QUESTION 1 result.
SELECT
    COUNT(*) AS Joined_Rows,
    ROUND(SUM(o.SalesTotal), 2) AS Joined_Revenue
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina';

-- QUESTION 6: Recommendation for the next quarter
-- Based on the analysis, I recommend that EmporiUm focus sales
-- attention on strengthening North Carolina's online sales.
--
-- Technology & Accessories generated $254,968.35, approximately
-- 73.6% of North Carolina's $346,285.31 in online revenue.
-- North Carolina ranked fourth among the four South Region states
-- analyzed, with 386 sales transactions.
--
-- Maintain support for Technology & Accessories while testing
-- targeted promotions and cross-selling in other categories.
-- Monitor transaction counts, category revenue, and average
-- transaction values to evaluate the impact next quarter.
--
-- These recommendations are based on the supplied historical
-- results and should be tested rather than assumed effective.
