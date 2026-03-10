-- Average price per product category
SELECT 
    pr.product_category_name,
    ROUND(AVG(oi.price_usd), 2) AS avg_price_usd,
    COUNT(oi.order_line_number) AS total_items_sold
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY avg_price_usd DESC;


-- Average freight value per product category
-- Identifies which categories are most expensive to ship
SELECT 
    pr.product_category_name,
    ROUND(AVG(oi.freight_value)* 0.19, 2) AS avg_freight_usd,
    ROUND(AVG(pr.product_weight_g), 2) AS avg_weight_g
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY avg_freight DESC;


-- Freight to price ratio per category
-- High ratio means customers pay a lot in shipping relative to product price
-- A known driver of cart abandonment in e-commerce
SELECT 
    pr.product_category_name,
    ROUND(AVG(oi.freight_value) *0.19, 2) AS avg_freight_usd,
    ROUND(AVG(oi.price)*0.19, 2) AS avg_price_usd,
    ROUND(AVG(oi.freight_value) / AVG(oi.price) * 100, 2) AS freight_to_price_ratio
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY freight_to_price_ratio DESC;


-- ─────────────────────────────────────────────────────────────
-- order_items + payments + products combined
-- ─────────────────────────────────────────────────────────────

-- Total revenue per product category
SELECT 
    pr.product_category_name,
    ROUND(SUM(p.payment_value)*0.19, 2) AS total_revenue_usd,
    COUNT(DISTINCT p.order_id) AS total_orders
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
JOIN payments p ON oi.order_id = p.order_id
GROUP BY pr.product_category_name
ORDER BY total_revenue_usd DESC;



-- Freight to price ratio including payment value
-- Shows categories where shipping cost is disproportionate to what customers paid
SELECT 
    pr.product_category_name,
    ROUND(SUM(oi.freight_value)*0.19, 2) AS total_freight_usd,
    ROUND(SUM(p.payment_value)*0.19, 2) AS total_revenue_usd,
    ROUND(SUM(oi.freight_value) / SUM(p.payment_value) * 100, 2) AS freight_to_revenue_ratio
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
JOIN payments p ON oi.order_id = p.order_id
GROUP BY pr.product_category_name
ORDER BY freight_to_revenue_ratio DESC;