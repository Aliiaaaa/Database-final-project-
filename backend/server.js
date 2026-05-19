const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'online_store',
    password: 'MyNewSecret123',
    port: 5432
});

app.post('/api/login', (req, res) => {

    const { username, password } = req.body;

    if(username === 'admin' && password === '1234') {

        res.json({
            success: true,
            message: 'Login successful'
        });

    } else {

        res.status(401).json({
            success: false,
            message: 'Invalid credentials'
        });
    }
});

app.get('/api/stats', async (req, res) => {

    try {

        const products = await pool.query(
            'SELECT COUNT(*) FROM products'
        );

        const orders = await pool.query(
            'SELECT COUNT(*) FROM orders'
        );

        const users = await pool.query(
            'SELECT COUNT(*) FROM users'
        );

        const revenue = await pool.query(
            'SELECT SUM(amount) FROM payments WHERE status = $1',
            ['paid']
        );

        res.json({
            totalProducts: products.rows[0].count,
            totalOrders: orders.rows[0].count,
            totalUsers: users.rows[0].count,
            totalRevenue: revenue.rows[0].sum || 0
        });

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.get('/api/products', async (req, res) => {

    try {

        const result = await pool.query(`
            SELECT
                p.product_id,
                p.product_name,
                p.price,
                p.stock,
                c.category_name
            FROM products p
            LEFT JOIN categories c
            ON p.category_id = c.category_id
            ORDER BY p.product_id ASC
        `);

        res.json(result.rows);

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.post('/api/products', async (req, res) => {

    try {

        const {
            product_name,
            price,
            stock
        } = req.body;

        await pool.query(
            `
            INSERT INTO products
            (product_name, price, stock)
            VALUES ($1, $2, $3)
            `,
            [product_name, price, stock]
        );

        res.send('Product added');

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.delete('/api/products/:id', async (req, res) => {

    try {

        const id = req.params.id;

        await pool.query(
            `
            DELETE FROM products
            WHERE product_id = $1
            `,
            [id]
        );

        res.send('Product deleted');

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.get('/api/orders', async (req, res) => {

    try {

        const result = await pool.query(`
            SELECT
                o.order_id,
                u.name,
                o.status,
                o.created_at
            FROM orders o
            JOIN users u
            ON o.user_id = u.user_id
            ORDER BY o.order_id ASC
        `);

        res.json(result.rows);

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.get('/api/users', async (req, res) => {

    try {

        const result = await pool.query(`
            SELECT *
            FROM users
            ORDER BY user_id ASC
        `);

        res.json(result.rows);

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.get('/api/payments', async (req, res) => {

    try {

        const result = await pool.query(`
            SELECT *
            FROM payments
            ORDER BY payment_id ASC
        `);

        res.json(result.rows);

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.get('/api/deliveries', async (req, res) => {

    try {

        const result = await pool.query(`
            SELECT *
            FROM deliveries
            ORDER BY delivery_id ASC
        `);

        res.json(result.rows);

    } catch (err) {

        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

app.listen(5000, () => {

    console.log('Server started on http://localhost:5000');
});