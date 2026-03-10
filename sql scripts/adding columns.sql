-- Adding the response time in days to the rewiews table
ALTER TABLE reviews ADD COLUMN response_time_days FLOAT;

UPDATE reviews
SET response_time_days = DATEDIFF(review_answer_timestamp, review_creation_date);	
-- Adding the response time in hours to the rewiews table
ALTER TABLE reviews ADD COLUMN response_time_hours FLOAT;

UPDATE reviews
SET response_time_hours = TIMESTAMPDIFF(HOUR, review_creation_date, review_answer_timestamp);

-- Adding the day column to the orders table
ALTER TABLE orders ADD COLUMN order_day VARCHAR(10);

UPDATE orders
SET order_day = DAYNAME(order_purchase_timestamp);
-- Adding the hour column to the orders table
ALTER TABLE orders ADD COLUMN order_hour INT;

UPDATE orders
SET order_hour = HOUR(order_purchase_timestamp);

ALTER TABLE payments ADD COLUMN payment_value_usd FLOAT;

UPDATE payments
SET payment_value_usd = ROUND(payment_value * 0.19, 2);

ALTER TABLE order_items ADD COLUMN price_usd FLOAT;

UPDATE order_items
SET price_usd = ROUND(price * 0.19, 2);