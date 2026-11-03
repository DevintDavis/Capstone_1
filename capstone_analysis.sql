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
DESCRIBE sample_sales.Store_Locations;

SELECT StoreId, State, StoreLocation
FROM sample_sales.Store_Locations
WHERE State = 'North Carolina';

SELECT *
FROM sample_sales.Online_Sales
WHERE State = 'North Carolina'
LIMIT 10;

DESCRIBE sample_sales.Online_Sales;


-- Question 1: North Carolina Online Sales
SELECT
    SUM(SalesTotal) AS Total_Revenue,
    MIN(Date) AS Start_Date,
    MAX(Date) AS End_Date
FROM sample_sales.Online_Sales
WHERE ShiptoState = 'North Carolina';

-- Question 2: North Carolina Monthly Revenue
SELECT
    YEAR(Date) AS Sales_Year,
    MONTH(Date) AS Sales_Month,
    SUM(SalesTotal) AS Monthly_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState = 'North Carolina'
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Sales_Year, Sales_Month;
