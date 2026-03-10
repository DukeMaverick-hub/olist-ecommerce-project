-- Overall review score distribution
-- Shows how many reviews fall into each score category
SELECT 
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM reviews) * 100, 2) AS percentage
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- Average review score per product category
-- Identifies which categories have the most satisfied customers
SELECT 
    p.product_category_name,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN order_items oi ON r.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_review_score DESC;

-- Response time vs review score
-- Checks if faster review responses correlate with better scores
SELECT 
    review_score,
    ROUND(AVG(response_time_hours), 2) AS avg_response_hours
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Review score vs delivery time
-- Checks if late deliveries lead to lower review scores
SELECT 
    r.review_score,
    ROUND(AVG(TIMESTAMPDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date)), 2) AS avg_delivery_days
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
GROUP BY r.review_score
ORDER BY r.review_score DESC;