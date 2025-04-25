-- Q1: top 10 most profitable products. 
SELECT product_name, SUM(profit) AS total_profit 
FROM superstore 
GROUP BY product_name 
ORDER by total_profit DESC
LIMIT 10


-- regions  generating the highest total sales
SELECT region, SUM (sales) AS total_sales
FROM superstore 
GROUP BY region 
ORDER BY total_sales DESC


-- Month to month total sales comparison

SELECT EXTRACT(MONTH FROM order_date) as month, EXTRACT(YEAR FROM order_date) AS year, SUM(sales) AS total_sales 
FROM superstore
GROUP BY month, year
ORDER BY year ASC , month ASC 


--top 5 customers based on total profit

SELECT customer_id, customer_name,  SUM (profit) AS total_profit
FROM superstore
GROUP BY customer_name, customer_id
ORDER BY total_profit DESC
LIMIT 5 


-- Average profit for each customer
SELECT customer_id, AVG(order_profit) as AVG_order_profit 
FROM ( 
SELECT customer_id, customer_name, order_id, SUM(profit) AS order_profit
FROM superstore 
GROUP BY customer_id, order_id, customer_name
) AS order_summary
GROUP BY customer_id
ORDER BY AVG_order_profit DESC LIMIT 5 


-- What shipping mode is used most often?
SELECT ship_mode, COUNT (ship_mode) high_ship_mode 
FROM superstore
GROUP BY ship_mode
ORDER BY high_ship_mode DESC  


--  percentage of total orders that each shipping mode represents. 
SELECT ship_mode, COUNT (*) * 100/ SUM(COUNT(*)) OVER () AS ship_mode_percentage
FROM superstore
GROUP BY ship_mode
ORDER BY ship_mode_percentage DESC


-- product categories have the lowest average profit 
SELECT category, sub_category, AVG(profit) as AVG_profit
FROM superstore
GROUP BY category, sub_category
ORDER BY AVG_profit ASC


-- Regions that generate the highest total sales. 
SELECT region, ROUND (SUM(sales), 2) AS total_sales, ROUND (SUM(profit),2) AS total_profit 
FROM superstore
GROUP BY region
ORDER BY total_sales DESC  

-- sub-category with the highest average discount 
SELECT sub_category, ROUND(AVG(discount),2) as AVG_discount, ROUND(AVG(profit),2) AS AVG_profit
FROM superstore 
GROUP BY sub_category
ORDER BY AVG_discount DESC  


-- top 10 cities with the highest number of orders that resulted in a loss
WITH loss AS 
( 
    SELECT order_id, city, SUM (profit) AS total_profit 
    FROM superstore 
    GROUP BY order_id, city
    HAVING SUM(profit) < 0
) 

SELECT city, 
        COUNT(order_id) loss_order_count,
        SUM(total_profit) AS total_loss
FROM loss 
GROUP BY city
ORDER BY loss_order_count DESC 
LIMIT 10;


-- Scenario: Classifying Customer Value Tiers
-- The marketing team wants to segment customers into value categories based on their profitability:
-- High-Value: Total profit > 5000
-- Mid-Value: Total profit between 0 and 5000
-- Loss-Making: Total profit < 0
-- Task:
-- For each customer, show:
-- Customer ID Customer Name Total Sales Total Profit Total Orders Value Category (use CASE WHEN logic)
-- Then:
-- Sort by total_profit in descending order. 

SELECT COUNT(DISTINCT order_id) AS order_count, customer_id, customer_name, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
CASE 
    WHEN SUM(profit) > 5000 THEN 'High-Value Customer'
    WHEN SUM(profit) BETWEEN 0 AND 5000 THEN 'Mid-Value Customer'
    ELSE 'Loss-Making Customer'
END  AS customersCategorization
FROM superstore
GROUP BY customer_id, customer_name
HAVING SUM(sales) > 10000 
ORDER BY total_profit DESC   


-- products have been ordered more than 25 times with an average discount greater than 1%

SELECT COUNT(DISTINCT order_id) AS order_count,
product_name, ROUND(AVG(discount),2) AS average_discount
FROM superstore
GROUP BY product_name
HAVING COUNT(DISTINCT order_id) > 25 AND AVG(discount) > 0.01
ORDER BY order_count DESC


--  sub-categories that  have generated over $50,000 in total sales with  an average profit per order lower than $20.
SELECT COUNT(DISTINCT order_id) AS order_count, sub_category, SUM(sales) AS total_sales,
ROUND(AVG(profit),2) as average_profit, ROUND(SUM(profit)/COUNT(DISTINCT order_id),2) as average_profit_per_order
FROM superstore
GROUP BY sub_category
HAVING SUM(sales) > 50000 AND SUM(profit)/COUNT(DISTINCT order_id) < 20
ORDER BY average_profit_per_order DESC





