-- Q1: top 10 most profitable products. 
SELECT product_name, SUM(profit) AS total_profit 
FROM superstore 
GROUP BY product_name 
ORDER by total_profit DESC
LIMIT 10
