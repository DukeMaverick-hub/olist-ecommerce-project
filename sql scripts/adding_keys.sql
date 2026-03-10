-- Note that it is important to modify the id's from text to varchar before assigning keys to them
-- customers
ALTER TABLE customers MODIFY customer_id VARCHAR(50);
ALTER TABLE customers ADD PRIMARY KEY (customer_id);

-- sellers
ALTER TABLE sellers MODIFY seller_id VARCHAR(50);
ALTER TABLE sellers ADD PRIMARY KEY (seller_id);

-- products
ALTER TABLE products MODIFY product_id VARCHAR(50);
ALTER TABLE products ADD PRIMARY KEY (product_id);

-- orders
ALTER TABLE orders MODIFY order_id VARCHAR(50);
ALTER TABLE orders MODIFY customer_id VARCHAR(50);
ALTER TABLE orders ADD PRIMARY KEY (order_id);
ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- order_items
ALTER TABLE order_items MODIFY order_id VARCHAR(50);
ALTER TABLE order_items MODIFY product_id VARCHAR(50);
ALTER TABLE order_items MODIFY seller_id VARCHAR(50);
ALTER TABLE order_items ADD PRIMARY KEY (order_id, order_line_number);
ALTER TABLE order_items ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products(product_id);
ALTER TABLE order_items ADD FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

-- payments
ALTER TABLE payments MODIFY order_id VARCHAR(50);
ALTER TABLE payments ADD PRIMARY KEY (order_id, payment_sequential);
ALTER TABLE payments ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);	

-- reviews
ALTER TABLE reviews MODIFY review_id VARCHAR(50);
ALTER TABLE reviews MODIFY order_id VARCHAR(50);
ALTER TABLE reviews ADD PRIMARY KEY (review_id, order_id);
ALTER TABLE reviews ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);