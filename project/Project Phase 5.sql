
-- Use the ecommerce database
USE ecommerce_db;

-- Products Table (1NF Applied)
-- This table is in First Normal Form (1NF) because:
-- 1. Each column stores just one piece of information (for example, the "ProductName" column only contains the name of the product).
-- 2. There are no lists or multiple values in any column (for example, the "Price" column only has one price per product, not a list of prices).

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each product
    ProductName VARCHAR(255) NOT NULL, -- Stores just the name of the product
    Description TEXT, -- Stores a description of the product
    Price DECIMAL(10, 2) NOT NULL, -- Stores a single price for the product
    StockQuantity INT NOT NULL, -- Stores the number of items in stock
    Category VARCHAR(100), -- Stores the category of the product
    DateAdded DATE NOT NULL DEFAULT (CURDATE()) -- Stores the date when the product was added
);

-- Users Table (2NF Applied)
-- This table is in Second Normal Form (2NF) because:
-- 1. It's already in 1NF (each column has only one piece of information).
-- 2. Every piece of information in the table (like "UserName" and "Email") depends directly on the primary key ("UserID"). 
--    This means that if you know the UserID, you can find the UserName, Email, and Address, and none of these depends on anything else.

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each user
    UserName VARCHAR(255) NOT NULL, -- Stores the user's name
    Email VARCHAR(255) NOT NULL UNIQUE, -- Stores the user's email, which must be unique
    Address VARCHAR(255) -- Stores the user's address
);

-- Orders Table (3NF Applied)
-- This table is in Third Normal Form (3NF) because:
-- 1. It's already in 2NF (all the information depends on the primary key, "OrderID").
-- 2. There are no extra dependencies between the other columns (for example, "TotalAmount" depends only on "OrderID" and nothing else).

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each order
    UserID INT, -- Links to the user who made the order
    OrderDate DATE NOT NULL, -- Stores the date the order was made
    TotalAmount DECIMAL(10, 2) NOT NULL, -- Stores the total amount of the order
    FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Links to the Users table
);

-- Payments Table (3NF Applied)
-- This table is also in Third Normal Form (3NF) because:
-- 1. It's already in 2NF (all the information depends on the primary key, "PaymentID").
-- 2. Every piece of information (like "PaymentMethod" and "Amount") depends only on the primary key, "PaymentID".

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each payment
    OrderID INT, -- Links to the order that the payment is for
    PaymentMethod VARCHAR(50), -- Stores the payment method (e.g., Credit Card)
    PaymentDate DATE NOT NULL, -- Stores the date the payment was made
    Amount DECIMAL(10, 2) NOT NULL, -- Stores the amount of the payment
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) -- Links to the Orders table
);

-- Reviews Table (3NF Applied)
-- This table is in Third Normal Form (3NF) because:
-- 1. It's already in 2NF (all the information depends on the primary key, "ReviewID").
-- 2. Every piece of information (like "Rating" and "ReviewText") depends only on the primary key, "ReviewID".

CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each review
    ProductID INT, -- Links to the product that the review is for
    UserID INT, -- Links to the user who wrote the review
    Rating INT CHECK (Rating >= 1 AND Rating <= 5), -- Stores the rating given by the user (1 to 5)
    ReviewText TEXT, -- Stores the text of the review
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID), -- Links to the Products table
    FOREIGN KEY (UserID) REFERENCES Users(UserID) -- Links to the Users table
);

-- Note:
-- Use this script as you follow along with the videos. It will help you see how the different forms of normalization (1NF, 2NF, 3NF)
-- are applied to each table in the database. This will make your database more efficient and easier to manage.
