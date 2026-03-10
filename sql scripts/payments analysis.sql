-- query 1: The total amount of revenue in usd
SELECT round(SUM(payment_value_usd),2) AS Total_revenue
FROM payments;

-- query 2: Average payment value per item in usd
SELECT 
    ROUND(SUM(p.payment_value_usd) / COUNT(oi.order_line_number), 2) AS avg_payment_per_item
FROM payments p
JOIN order_items oi ON p.order_id = oi.order_id;

-- query 3:  what percentage of total payment is just shipping costs
SELECT 
    ROUND(SUM(oi.freight_value), 2) AS total_freight,
    ROUND(SUM(p.payment_value), 2) AS total_payment,
    ROUND(SUM(oi.freight_value) / SUM(p.payment_value) * 100, 2) AS freight_percentage
FROM order_items oi
JOIN payments p ON oi.order_id = p.order_id;

-- query 4: Average payment value by payment type
-- Identifies which payment type is used for high vs low value orders
SELECT 
    p.payment_type,
    ROUND(AVG(p.payment_value), 2) AS avg_order_value,
    COUNT(DISTINCT p.order_id) AS total_orders
FROM payments p
JOIN order_items oi ON p.order_id = oi.order_id
GROUP BY p.payment_type
ORDER BY avg_order_value DESC;

