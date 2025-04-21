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
