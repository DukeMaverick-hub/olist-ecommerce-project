-- Query 1:comparing the customer city to delivery times  
select 
c.customer_city,
avg(o.delivery_time_days) as Avg_delivery_time_days
from customers c
join orders o 
on c.customer_id = o.customer_id
group by c.customer_city
having avg(o.delivery_time_days) IS NOT NULL
ORDER BY Avg_delivery_time_days DESC;

-- Query 2: Total customers per state
SELECT customer_state, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- Query 3: Top spending customers
SELECT customer_id, SUM(payment_value_usd) AS total_spent_usd
FROM payments
JOIN orders ON payments.order_id = orders.order_id
GROUP BY customer_id
ORDER BY total_spent_usd DESC;

-- Query 4: Average orders per city
SELECT customer_city, COUNT(order_id) AS total_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customer_city
ORDER BY total_orders DESC;

-- Query 5: most common payment methods used by customers
SELECT payment_type, COUNT(customer_id) AS number_of_customers
FROM payments
JOIN orders ON payments.order_id = orders.order_id
GROUP BY payment_type
ORDER BY number_of_customers DESC;