-- Chapter 7: Data Analysis and Reporting

-- Switch to the appropriate database
USE ecommerce_db;

-- 1. Total Sales
-- This query calculates the total revenue generated from all orders in the database.
SELECT 
    SUM(TotalAmount) AS TotalSales 
FROM 
    Orders;






-- 2. Sales by Month
-- This query calculates the total sales for each month by formatting the OrderDate.
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month, 
    SUM(TotalAmount) AS MonthlySales
FROM 
    Orders
GROUP BY 
    Month
ORDER BY 
    Month;


-- Analyzing Customer Behavior

-- 1. Top Customers
-- This query identifies the top 5 customers who have spent the most on the platform.
SELECT 
    UserID, 
    SUM(TotalAmount) AS TotalSpent
FROM 
    Orders
GROUP BY 
    UserID
ORDER BY 
    TotalSpent DESC
LIMIT 5;

-- 2. Customer Lifetime Value (CLTV)
-- This query calculates the Customer Lifetime Value (CLTV) for each customer, 
-- which is the total amount a customer has spent on the platform.
SELECT 
    UserID, 
    SUM(TotalAmount) AS LifetimeValue
FROM 
    Orders
GROUP BY 
    UserID
ORDER BY 
    LifetimeValue DESC;

-- Analyzing Product Performance
-- 1. Average Product Price
-- This query calculates the average price of all products in the inventory.
SELECT 
    AVG(Price) AS AverageProductPrice
FROM 
    Products;


-- 2. Total Inventory Value
-- This query calculates the total value of the inventory by multiplying the price of each product by its stock quantity.
SELECT 
    SUM(Price * StockQuantity) AS TotalInventoryValue
FROM 
    Products;
    
    
    
    
    
    
    
    
