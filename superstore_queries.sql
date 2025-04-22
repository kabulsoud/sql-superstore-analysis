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


