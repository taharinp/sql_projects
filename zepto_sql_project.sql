DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountpercent NUMERIC(5,2),
    availablequantity INTEGER,
    discountedsellingsprice NUMERIC(8,2),
    weightingms INTEGER,
    outofstock BOOLEAN,
    quantity INTEGER
);

--data exploration

--count of rows

SELECT COUNT(*) FROM zepto;
SELECT current_database();
--sample data 
SELECT * FROM zepto LIMIT 10;

--null values
select * from zepto
where name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR

discountpercent IS NULL
OR
discountedsellingsprice IS NULL
OR
outofStock IS NULL
OR
availablequantity IS NULL
OR
quantity IS NULL
OR
weightingms IS NULL;


--different product categories

SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock
select outofstock,COUNT(sku_id)
from zepto
group by outofstock;


--products name
select name, count(sku_id)as "number of skus"
from zepto
GROUP BY name
having count (sku_id)>1
order by gr(sku_id)DESC;


--identify top 5 category offering highest avg discount percentage
select category,
round (avg(discountpercent),2)as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;


-- price per grm for product above 100g and sort by best value
SELECT DISTINCT name, weightInGms, discountedsellingsprice,
       ROUND(discountedsellingsprice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

--group the products into category like low,medium,bulk

select distinct name,weightInGms,
case when weightInGms < 1000 then 'low'
when weightInGms <5000 then 'medium'
else 'bulk'
end as weight_category
from zepto;


--total inventory weight per category

SELECT category,
       SUM(weightInGms * availableQuality) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;


-- calculate estimated revenuw
SELECT category,
       SUM(discountedsellingsprice * availablequantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

--find all product where mrp is >500 and discount is less than 100
select distinct name,mrp,discountpercent
from zepto
where mrp>500 and discountpercent<10
order by mrp desc,discountpercent desc;



SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'zepto'
ORDER BY ordinal_position








