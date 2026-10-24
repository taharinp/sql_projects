-- Select the database to use
USE ecommerce_db;

/* **DATA VERIFICATION** */

-- 1. CHECK FOR MISSING DATA
-- Check for missing values in the Products table
-- This query identifies any records in the Products table where critical fields (ProductName, Price, StockQuantity) are missing.
SELECT 
    * 
FROM 
    Products 
WHERE 
    ProductName IS NULL 
    OR Price IS NULL 
    OR StockQuantity IS NULL;

-- Perform similar checks for other tables, like Users
-- This query checks the Users table for missing Email or UserName values, which are crucial for identifying users.
SELECT 
    * 
FROM 
    Users 
WHERE 
    Email IS NULL 
    OR UserName IS NULL;


-- 2. VALIDATE DATA FORMATS
-- Check that all email addresses in the Users table are correctly formatted
-- This query ensures that every email address follows a basic format (e.g., user@example.com). It's a simple way to catch obvious errors.
SELECT 
    * 
FROM 
    Users 
WHERE 
    Email NOT LIKE '%_@__%.__%';


-- 3. STANDADIZE DATA FORMATS
-- Check all dates in the Orders table are within a reasonable range
-- This query checks that the OrderDate field contains realistic dates, ensuring no dates are in the distant past or future.
SELECT 
    * 
FROM 
    Orders 
WHERE 
    OrderDate < '2000-01-01' 
    OR OrderDate > CURDATE();


-- 4. CHECK FOR DUPLICATE ENTRIES
-- Check for duplicate UserIDs in the Users table
-- This query looks for any duplicate UserIDs, which should be unique for each user.
SELECT 
    UserID, 
    COUNT(*) 
FROM 
    Users 
GROUP BY 
    UserID 
HAVING 
    COUNT(*) > 1;

-- If duplicates are found, you may need to remove or merge the duplicates
-- The example below shows how to delete a specific UserID if it's identified as a duplicate.
DELETE FROM 
    Users 
WHERE 
    UserID IN (99999);









-- 5. ENFORCING CONSTRAINTS
-- Ensure Non-Negative Prices
-- This constraint ensures that no product can have a negative price, which would be unrealistic.
ALTER TABLE 
    Products
ADD CONSTRAINT 
    chk_price CHECK (Price >= 0);

-- Ensure email addresses follow a basic format
-- This constraint enforces that every email in the Users table follows a standard format (e.g., user@example.com).
ALTER TABLE 
    Users
ADD CONSTRAINT 
    chk_email CHECK (Email LIKE '%_@__%.__%');



-- 6. CASCADING DELETES
-- If a user is deleted, ensure that their associated orders are also deleted to avoid orphaned records
-- This foreign key constraint ensures that if a user is removed from the Users table, 
-- their associated orders are automatically deleted.
ALTER TABLE 
    Orders
ADD CONSTRAINT 
    fk_user
FOREIGN KEY 
    (UserID) REFERENCES Users(UserID)
ON DELETE 
    CASCADE;


-- 7. USING TRANSACTIONS TO MAINTAIN INTEGRITY
-- To process an order that affects both the Orders and Products tables
-- Transactions allow you to ensure that all parts of a multi-step operation are completed successfully before making any permanent changes.

START TRANSACTION;
-- Insert a new order
-- This step adds a new order to the Orders table.
INSERT INTO 
    Orders (OrderID, UserID, OrderDate, TotalAmount)
VALUES 
    (1008, 286, '2024-08-17', 99.99);
-- Update stock quantity
-- This step reduces the stock quantity of a product in the Products table after an order is placed.
UPDATE 
    Products 
SET 
    StockQuantity = StockQuantity - 1 
WHERE 
    ProductID = 1677;
-- If everything is successful
-- COMMIT finalizes the transaction, saving all changes made in the transaction.
COMMIT;
-- If something goes wrong
-- ROLLBACK undoes all changes made in the transaction, ensuring the database remains consistent.
ROLLBACK;










/*
When applying constraints or ALTER statements, you might encounter a timeout error like:

Error Code: 2013. Lost connection to MySQL server during query

Here’s what to do:
Check Running Queries:

Use SHOW PROCESSLIST; to see what queries are running and identify any long-running or stuck processes.
Terminate Problematic Queries:

Use KILL <process_id>; to stop a process that’s causing the timeout (replace <process_id> with the actual ID from SHOW PROCESSLIST).

This helps you quickly resolve issues and keep working without delays.
*/
