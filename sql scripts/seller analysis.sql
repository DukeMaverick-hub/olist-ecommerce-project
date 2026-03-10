-- Total orders per seller
-- Identifies the most active sellers on the platform
SELECT 
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY total_orders DESC;


-- Total revenue per seller
-- Shows which sellers are generating the most money
SELECT 
    s.seller_id,
    s.seller_state,
    ROUND(SUM(oi.price)*0.19, 2) AS total_revenue_usd,
    ROUND(AVG(oi.price)*0.19, 2) AS avg_item_price_usd
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_state
ORDER BY total_revenue_usd DESC;


-- Total revenue per seller state
-- Identifies which states have the most commercially active sellers
SELECT 
    s.seller_state,
    COUNT(DISTINCT s.seller_id) AS total_sellers,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price)*0.19, 2) AS total_revenue_usd
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue_usd DESC;


-- Average freight value per seller
-- High freight costs could indicate sellers in remote locations
SELECT 
    s.seller_id,
    s.seller_state,
    ROUND(AVG(oi.freight_value)*0.19, 2) AS avg_freight_usd,
    ROUND(AVG(oi.price)*0.19, 2) AS avg_price_usd,
    ROUND(AVG(oi.freight_value) / AVG(oi.price) * 100, 2) AS freight_to_price_ratio
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_state
ORDER BY avg_freight_usd DESC;


-- Top selling product categories per seller
-- Shows what each seller specialises in
SELECT 
    s.seller_id,
    p.product_category_name,
    COUNT(oi.order_line_number) AS total_items_sold,
    ROUND(SUM(oi.price)*0.19, 2) AS total_revenue_usd
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY s.seller_id, p.product_category_name
ORDER BY total_items_sold DESC;