-- Portfolio 5: Distributed and Cloud Database Strategy (ShopEasy Global Scaling)
-- Database: shopeasy_db

-- Connect to our database
\c shopeasy_db

-- 1. CLOUD ARCHITECTURE OVERVIEW TABLE
-- We create a tracking table to document our multi-region read-replicas 
-- and sharding strategy for handling millions of global e-commerce users.
CREATE TABLE cloud_deployment_nodes (
    node_id SERIAL PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    role VARCHAR(30) NOT NULL, -- e.g., 'Primary Write Node', 'Read Replica'
    cloud_provider VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);

-- 2. INSERT GLOBAL INFRASTRUCTURE NODES
INSERT INTO cloud_deployment_nodes (region, role, cloud_provider) VALUES 
('US-East (Virginia)', 'Primary Write Node (Master)', 'AWS RDS PostgreSQL'),
('EU-West (Frankfurt)', 'Global Read Replica', 'AWS RDS PostgreSQL'),
('AP-Southeast (Singapore)', 'Global Read Replica', 'AWS RDS PostgreSQL');

-- 3. SHARDING STRATEGY DEMONSTRATION (Horizontal Partitioning by Region/Customer ID)
-- For a massive e-commerce platform, orders are sharded across regions.
CREATE TABLE orders_shard_us (
    LIKE orders INCLUDING ALL
);

CREATE TABLE orders_shard_international (
    LIKE orders INCLUDING ALL
);

-- 4. VERIFY CLOUD NODE SETUP
SELECT node_id, region, role, cloud_provider, status 
FROM cloud_deployment_nodes;