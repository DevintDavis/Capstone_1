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
-- Question 3: Compare North Carolina online
-- sales revenue with its region
DESCRIBE sample_sales.Management;

SELECT DISTINCT Region, State
FROM sample_sales.Management
WHERE State = 'North Carolina';

SELECT DISTINCT Region, State
FROM sample_sales.Management
ORDER BY Region, State;

SELECT
    ShiptoState AS State,
    SUM(SalesTotal) AS Total_Revenue
FROM sample_sales.Online_Sales
GROUP BY ShiptoState
ORDER BY Total_Revenue DESC;

-- Question 3: Total South Region Online Revenue
SELECT
    SUM(SalesTotal) AS South_Region_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState IN (
    'North Carolina',
    'South Carolina',
    'Florida',
    'Texas'
);

-- Question 3: Compare individual states
SELECT
    ShiptoState AS State,
    SUM(SalesTotal) AS Total_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState IN (
    'North Carolina',
    'South Carolina',
    'Florida',
    'Texas'
)
GROUP BY ShiptoState
ORDER BY Total_Revenue DESC;


-- Verify Question 3: Regional sales comparison
SELECT
    ShiptoState AS State,
    SUM(SalesTotal) AS Total_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState IN (
    'North Carolina',
    'South Carolina',
    'Florida',
    'Texas'
)
GROUP BY ShiptoState
ORDER BY Total_Revenue DESC;

DESCRIBE sample_sales.Online_Sales;
DESCRIBE sample_sales.Products;

-- Question 4: Explore online sales and product categories
SELECT
    o.Date,
    o.ProdNum,
    o.SalesTotal,
    p.CategoryId
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
WHERE o.ShiptoState = 'North Carolina'
LIMIT 10;
DESCRIBE sample_sales.Inventory_Categories;

-- Question 4: North Carolina online sales by category
SELECT
    c.Category,
    COUNT(*) AS Transaction_Count,
    SUM(o.SalesTotal) AS Total_Revenue,
    AVG(o.SalesTotal) AS Average_Transaction
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina'
GROUP BY c.Category
ORDER BY Total_Revenue DESC;



-- Question 4: Monthly online sales by product category
SELECT
    YEAR(o.Date) AS Sales_Year,
    MONTH(o.Date) AS Sales_Month,
    c.Category,
    SUM(o.SalesTotal) AS Total_Revenue
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina'
GROUP BY
    YEAR(o.Date),
    MONTH(o.Date),
    c.Category
ORDER BY
    Sales_Year,
    Sales_Month,
    Total_Revenue DESC;


SELECT
    COUNT(*) AS Sales_Rows,
    SUM(SalesTotal) AS Total_Revenue
FROM sample_sales.Online_Sales
WHERE ShiptoState = 'North Carolina';


SELECT
    COUNT(*) AS Joined_Rows,
    SUM(o.SalesTotal) AS Joined_Revenue
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina';


-- Question 4: Monthly category performance
-- North Carolina online sales

SELECT
    YEAR(o.Date) AS Sales_Year,
    MONTH(o.Date) AS Sales_Month,
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
GROUP BY
    YEAR(o.Date),
    MONTH(o.Date),
    c.Category
ORDER BY
    Sales_Year,
    Sales_Month,
    Total_Revenue DESC;

 
-- Verify North Carolina category totals
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

 
-- Final verification: North Carolina Online Sales
SELECT
    COUNT(*) AS Total_Sales_Rows,
    ROUND(SUM(SalesTotal), 2) AS Total_Revenue,
    ROUND(AVG(SalesTotal), 2) AS Average_Sale,
    MIN(Date) AS First_Sale_Date,
    MAX(Date) AS Last_Sale_Date
FROM sample_sales.Online_Sales
WHERE ShiptoState = 'North Carolina';
  
 
-- Verify category joins preserve all sales
SELECT
    COUNT(*) AS Joined_Rows,
    ROUND(SUM(o.SalesTotal), 2) AS Joined_Revenue
FROM sample_sales.Online_Sales AS o
JOIN sample_sales.Products AS p
    ON o.ProdNum = p.ProdNum
JOIN sample_sales.Inventory_Categories AS c
    ON p.CategoryId = c.CategoryId
WHERE o.ShiptoState = 'North Carolina';
 
