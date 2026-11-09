-- Portfolio 2: Query Processing and Optimisation
-- Database: shopeasy_db

-- Connect to our database
\c shopeasy_db

-- 1. BASIC JOIN QUERY: Find all orders with customer names and total amounts
SELECT o.order_id, c.full_name, o.total_amount, o.status, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 2. AGGREGATION QUERY: Calculate total spending per customer
SELECT c.full_name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name;

-- 3. QUERY PERFORMANCE ANALYSIS USING EXPLAIN
-- Let's see how PostgreSQL executes a search for a customer email
EXPLAIN ANALYZE 
SELECT * FROM customers WHERE email = 'alice@example.com';

-- 4. OPTIMISATION: Create an Index to speed up lookups on customer emails
CREATE INDEX idx_customer_email ON customers(email);

-- 5. RE-TEST PERFORMANCE AFTER INDEXING
-- Notice how the execution plan changes or uses an Index Scan!
EXPLAIN ANALYZE 
SELECT * FROM customers WHERE email = 'alice@example.com';