SELECT *
FROM sample_sales.Store_Sales
LIMIT 10;
DESCRIBE sample_sales.Store_Locations;
SELECT DISTINCT State, StoreLocation
FROM sample_sales.Store_Locations
ORDER BY State;
SELECT *
FROM sample_sales.Management
LIMIT 20;
SELECT *
FROM sample_sales.Store_Locations
WHERE State = 'South Carolina';
DESCRIBE sample_sales.Store_Sales;
SELECT
    SUM(Sale_Amount) AS Total_Revenue,
    MIN(Transaction_Date) AS Start_Date,
    MAX(Transaction_Date) AS End_Date
FROM sample_sales.Store_Sales
WHERE Store_ID IN (852, 853);
-- Question 2: Revenue by year and month
SELECT
    YEAR(Transaction_Date) AS Sales_Year,
    MONTH(Transaction_Date) AS Sales_Month,
    SUM(Sale_Amount) AS Monthly_Revenue
FROM sample_sales.Store_Sales
WHERE Store_ID IN (852, 853)
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date)
ORDER BY Sales_Year, Sales_Month;