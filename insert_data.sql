INSERT INTO users (name, email, phone)
VALUES
('Aliya', 'aliya@mail.com', '+996700000001'),
('Bek', 'bek@mail.com', '+996700000002'),
('Aibek', 'aibek@mail.com', '+996700000003'),
('Meerim', 'meerim@mail.com', '+996700000004'),
('Kanykei', 'kanykei@mail.com', '+996700000005');

INSERT INTO workers (name, role, phone)
VALUES
('Eldar', 'administrator', '+996700000111'),
('Adis', 'manager', '+996700000222'),
('Kubanych', 'manager', '+996700000333'),
('Aizada', 'courier', '+996700000444'),
('Azamat', 'administrator', '+996700000555');

INSERT INTO addresses (user_id, city, street, country)
VALUES
(1, 'Bishkek', 'Chuy 100', 'Kyrgyzstan'),
(2, 'Osh', 'Lenin 45', 'Kyrgyzstan'),
(3, 'Karakol', 'Toktogula 10', 'Kyrgyzstan'),
(4, 'Naryn', 'Central 5', 'Kyrgyzstan'),
(5, 'Talas', 'Aitmatova 77', 'Kyrgyzstan');

INSERT INTO categories (category_name)
VALUES
('Clothing'),
('Shoes'),
('Accessories');

INSERT INTO products (product_name, price, stock, category_id)
VALUES
('T-shirt', 20.00, 10, 1),
('Sneakers', 80.00, 5, 2),
('Hoodie', 45.00, 15, 1),
('Boots', 95.00, 10, 2),
('Backpack', 55.00, 12, 3);

INSERT INTO orders (user_id, address_id, status)
VALUES
(1, 1, 'completed'),
(2, 2, 'pending'),
(3, 3, 'shipped'),
(4, 4, 'completed'),
(5, 5, 'cancelled');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 20.00),
(2, 2, 1, 80.00),
(3, 3, 1, 45.00),
(4, 4, 1, 95.00),
(5, 5, 1, 55.00);

INSERT INTO payments (order_id, amount, payment_method, status)
VALUES
(1, 40.00, 'card', 'paid'),
(2, 80.00, 'cash', 'pending'),
(3, 45.00, 'card', 'paid'),
(4, 95.00, 'cash', 'paid'),
(5, 55.00, 'card', 'refunded');

INSERT INTO deliveries (order_id, tracking_number, delivery_status, estimated_date)
VALUES
(1, 'TRK123', 'delivered', '2026-05-20'),
(2, 'TRK456', 'in transit', '2026-05-25'),
(3, 'TRK789', 'shipped', '2026-05-28'),
(4, 'TRK321', 'delivered', '2026-05-18'),
(5, 'TRK654', 'cancelled', '2026-05-30');

INSERT INTO discounts (code, percentage, valid_until)
VALUES
('SALE10', 10, '2026-12-31'),
('SPRING15', 15, '2026-06-01');

INSERT INTO order_discounts (order_id, discount_id)
VALUES
(1, 1),
(3, 2);

INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES
(1, 1, 5, 'Good quality'),
(2, 2, 4, 'Comfortable shoes'),
(3, 3, 5, 'Warm hoodie'),
(4, 4, 4, 'Nice boots'),
(5, 5, 5, 'Strong backpack');
