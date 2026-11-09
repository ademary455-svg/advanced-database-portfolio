-- Portfolio 3: Transactions and Concurrency
-- Database: shopeasy_db

-- Connect to our database
\c shopeasy_db

-- 1. SUCCESSFUL TRANSACTION (COMMIT)
-- We simulate a customer placing an order: 
-- It adds an order and updates product stock safely inside a transaction block.

BEGIN;

-- Insert a new order for Alice (customer_id = 1)
INSERT INTO orders (customer_id, total_amount, status) 
VALUES (1, 50.00, 'Processing');

-- Update product stock (reducing stock for product_id = 1)
UPDATE products 
SET stock_quantity = stock_quantity - 1 
WHERE product_id = 1;

-- If everything looks good, we make the changes permanent:
COMMIT;

-- 2. FAILED TRANSACTION WITH ERROR (ROLLBACK)
-- We simulate an error (like running out of stock or invalid data) 
-- and rollback so the database doesn't get corrupted.

BEGIN;

-- Try to insert an order with an invalid customer ID (e.g., customer 999 doesn't exist)
INSERT INTO orders (customer_id, total_amount, status) 
VALUES (999, 150.00, 'Failed Attempt');

-- An error happens here! Let's manually trigger a ROLLBACK to undo changes
ROLLBACK;

-- 3. VERIFY TABLE DATA AFTER TRANSACTIONS
SELECT * FROM orders;
SELECT product_id, product_name, stock_quantity FROM products;