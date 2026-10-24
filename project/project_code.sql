
USE ecommerce_db;

DESCRIBE products;

SELECT * FROM products;


INSERT INTO products
(productname, description, price, stockquantity, category)
VALUES
('smartphone', 'latest model', 699.99, 50, 'Electronics');

SELECT * FROM products;


create table users(
userid int auto_increment primary key,
username varchar(555) not null,
email varchar(555) not null unique,
password varchar(255) not null,
address varchar(255),
dateregistered date not null default(curdate())

);
describe users;
select *from users;


create table orders(
orderid int auto_increment primary key,
userid int,
orderdate date not null,
totalamount decimal(10,2) not null,
foreign key(userid) references users(userid) 

);
ALTER TABLE orders
ADD COLUMN email VARCHAR(100);

ALTER TABLE orders
CHANGE COLUMN totalamount total DECIMAL(10,2) NOT NULL;
describe orders;
select *from orders;


CREATE TABLE reviews (
    reviewid INT AUTO_INCREMENT PRIMARY KEY,
    productid INT,
    userid INT,
    rating INT NOT NULL,
    reviewtext TEXT,
    FOREIGN KEY (productid) REFERENCES products(productid),
    FOREIGN KEY (userid) REFERENCES users(userid),
    CHECK (rating >= 1 AND rating <= 5)
);
DESCRIBE reviews;

SELECT * FROM reviews;

drop table reviews;
CREATE TABLE reviews (
    reviewid INT AUTO_INCREMENT PRIMARY KEY,
    productid INT,
    userid INT,
    rating INT,
    reviewtext TEXT,
    FOREIGN KEY (productid) REFERENCES products(productid),
    FOREIGN KEY (userid) REFERENCES users(userid)
);

create table payments(
paymentid int auto_increment primary key,
orderid int unique,
paymentmethod varchar(50),
paymentdate date not null,
amount decimal(10,2) not null,
foreign key (orderid) references orders(orderid)
);

describe payments;
select count(*) from payments;
ALTER TABLE payments
MODIFY paymentdate DATE NULL;
SELECT COUNT(*) FROM payments;

SELECT * FROM payments LIMIT 10;

SELECT COUNT(*) FROM orders;

INSERT INTO payments
(orderid, paymentmethod, paymentdate, amount)
VALUES
(1, 'Credit Card', '2026-10-25', 55000.00);

SELECT * FROM payments;
USE ecommerce_db;

INSERT INTO payments (orderid, paymentmethod, paymentdate, amount)
VALUES (1003, 'Credit Card', '2024-08-03', 978.27);

SELECT orderid, paymentmethod, paymentdate, amount
FROM payments;

SELECT o.orderid
FROM orders o
LEFT JOIN payments p ON o.orderid = p.orderid
WHERE p.orderid IS NULL;
INSERT INTO payments (orderid, paymentmethod, paymentdate, amount)
VALUES (2, 'Credit Card', '2024-08-03', 978.27);
SELECT * FROM payments;
SELECT orderid FROM payments;

CREATE TABLE payments_import (
    orderid INT,
    paymentmethod VARCHAR(50),
    paymentdate VARCHAR(30),
    amount DECIMAL(10,2)
);
SELECT * FROM payments_import;