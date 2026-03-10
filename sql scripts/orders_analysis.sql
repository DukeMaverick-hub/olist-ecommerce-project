-- SELECT *
-- FROM 
-- orders
-- LIMIT 10
-- query 1: Number of orders on each day of the week
SELECT order_day as day_of_the_week, COUNT(order_id) as number_of_orders
FROM orders
GROUP BY order_day
ORDER BY number_of_orders DESC;

-- query 2: Number of orders at each hour of the day
SELECT order_hour as hour_of_the_day, COUNT(order_id) as number_of_orders
FROM orders
GROUP BY order_hour
ORDER BY number_of_orders DESC;

-- query 3: Number of orders for each product category
SELECT p.product_category_name, count(o.order_id) as number_of_orders
FROM products p 
JOIN order_items o 
ON p.product_id = o.product_id
GROUP BY product_category_name
ORDER BY number_of_orders DESC;

-- query 4: Number of orders delivered or otherwise
SELECT order_status, count(order_id) AS num_of_orders
FROM orders 
GROUP BY order_status
ORDER BY num_of_orders DESC;

-- query 4: Number of orders per city
SELECT c.customer_city,  count(o.order_id) as num_of_orders
FROM orders o 
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_city;





