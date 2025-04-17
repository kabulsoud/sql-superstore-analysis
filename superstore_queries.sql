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
