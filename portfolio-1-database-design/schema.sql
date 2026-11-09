-- Portfolio 1: E-Commerce Database Schema (ShopEasy)
-- Database: PostgreSQL

-- 1. Create Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- 3. Create Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending'
);

-- Insert sample data to test our design
INSERT INTO customers (full_name, email) VALUES 
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com');

INSERT INTO products (product_name, price, stock_quantity) VALUES 
('Wireless Mouse', 25.50, 100),
('Mechanical Keyboard', 75.00, 50);

INSERT INTO orders (customer_id, total_amount, status) VALUES 
(1, 25.50, 'Completed'),
(2, 75.00, 'Processing');