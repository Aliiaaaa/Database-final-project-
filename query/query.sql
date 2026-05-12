SELECT * FROM users;

SELECT * FROM workers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT u.name, o.order_id, o.status
FROM users u
JOIN orders o 
ON u.user_id = o.user_id;

SELECT p.product_name, p.price, c.category_name
FROM products p
JOIN categories c 
ON p.category_id = c.category_id;

SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p 
ON oi.product_id = p.product_id
GROUP BY p.product_name;

SELECT u.name, r.rating, r.comment
FROM reviews r
JOIN users u 
ON r.user_id = u.user_id;

SELECT o.order_id, pay.amount, pay.status
FROM payments pay
JOIN orders o 
ON pay.order_id = o.order_id;

SELECT d.tracking_number, d.delivery_status, o.order_id
FROM deliveries d
JOIN orders o 
ON d.order_id = o.order_id;