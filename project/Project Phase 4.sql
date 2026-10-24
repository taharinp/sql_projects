-- Chapter 8: Query Optimization

-- Switch to the appropriate database
USE ecommerce_db;

-- 1. Retrieving All Columns from a Table

-- Before Optimization:
-- This query retrieves all columns from the Products table.
-- Using SELECT * can be inefficient, as it retrieves more data than necessary.
SELECT * 
FROM Products;

-- After Optimization:
-- This optimized query retrieves only the necessary columns: ProductName, Price, and StockQuantity.
-- By selecting specific columns, we reduce the amount of data transferred and improve query performance.
SELECT 
	ProductName, 
	Price, 
    StockQuantity 
FROM Products;

-- 2. Retrieving Product Information

-- Before Optimization:
-- This query retrieves ProductName, Price, and StockQuantity for all products in the 'Gizmos' category.
-- It might return a large number of rows, which can be inefficient.
SELECT 
	ProductName, 
    Price, 
    StockQuantity 
FROM 
	Products 
WHERE 
	Category = 'Gizmos';

-- After Optimization:
-- Adding a LIMIT clause to the query restricts the number of rows returned to the first 5.
-- This significantly reduces the workload on the database, especially when the full result set isn’t required.
SELECT 
	ProductName, 
	Price, 
    StockQuantity 
FROM 
	Products 
WHERE 
	Category = 'Gizmos' 
LIMIT 5;
















-- 3. Using the EXPLAIN Command
-- The EXPLAIN command is used to analyze the execution plan of a query.
-- It helps to understand how MySQL is processing the query, which is useful for optimization.
EXPLAIN SELECT 
	ProductName, 
    Price 
FROM 
	Products 
WHERE 
	Category = 'Instruments';








-- 4. Adding Indexes to Improve Performance
-- If the EXPLAIN command shows that a full table scan is being used, 
-- consider adding an index to the Category column to speed up the query.
CREATE INDEX idx_category ON Products(Category);








-- Run the EXPLAIN again to see how the query execution plan has improved with the index.
EXPLAIN SELECT 
	ProductName, 
    Price 
FROM 
	Products 
WHERE 
	Category = 'Instruments';
