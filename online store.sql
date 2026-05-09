DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workers (
    worker_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    phone VARCHAR(20),
    hired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    city VARCHAR(100),
    street VARCHAR(150),
    country VARCHAR(100)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    category_id INT REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    address_id INT REFERENCES addresses(address_id),
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id),
    quantity INT CHECK (quantity > 0),
    price DECIMAL(10,2)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    status VARCHAR(50),
    paid_at TIMESTAMP
);

CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    tracking_number VARCHAR(100),
    delivery_status VARCHAR(50),
    estimated_date DATE
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    product_id INT REFERENCES products(product_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE discounts (
    discount_id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE,
    percentage INT CHECK (percentage BETWEEN 0 AND 100),
    valid_until DATE
);

CREATE TABLE order_discounts (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    discount_id INT REFERENCES discounts(discount_id)
);

INSERT INTO users (name, email, phone)
VALUES
('Aliya', 'aliya@mail.com', '+996700000001'),
('Bek', 'bek@mail.com', '+996700000002');

INSERT INTO workers (name, role, phone)
VALUES
('Eldar', 'administrator', '+996700000111'),
('Adis', 'Manager', '+996700000222');

INSERT INTO addresses (user_id, city, street, country)
VALUES
(1, 'Bishkek', 'Chuy 100', 'Kyrgyzstan'),
(2, 'Osh', 'Lenin 45', 'Kyrgyzstan');

INSERT INTO categories (category_name)
VALUES
('Clothing'),
('Shoes');

INSERT INTO products (product_name, price, stock, category_id)
VALUES
('T-shirt', 20.00, 10, 1),
('Sneakers', 80.00, 5, 2);

INSERT INTO orders (user_id, address_id, status)
VALUES
(1, 1, 'completed'),
(2, 2, 'pending');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 20.00),
(1, 2, 1, 80.00),
(2, 2, 1, 80.00);

INSERT INTO payments (order_id, amount, payment_method, status)
VALUES
(1, 120.00, 'card', 'paid'),
(2, 80.00, 'cash', 'pending');

INSERT INTO deliveries (order_id, tracking_number, delivery_status, estimated_date)
VALUES
(1, 'TRK123', 'delivered', '2026-05-20'),
(2, 'TRK456', 'in transit', '2026-05-25');

INSERT INTO discounts (code, percentage, valid_until)
VALUES
('SALE10', 10, '2026-12-31');

INSERT INTO order_discounts (order_id, discount_id)
VALUES
(1, 1);

INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES
(1, 1, 5, 'Good quality'),
(2, 2, 4, 'Comfortable shoes');

SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM workers;

SELECT u.name, o.order_id, o.status
FROM users u
JOIN orders o ON u.user_id = o.user_id;

SELECT p.product_name, p.price, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;
