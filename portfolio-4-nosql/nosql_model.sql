-- Portfolio 4: NoSQL and Advanced Data Models (Document Store using JSONB)
-- Database: shopeasy_db

-- Connect to our database
\c shopeasy_db

-- 1. CREATE A NoSQL-STYLE TABLE
-- Instead of fixed columns, we use JSONB to store flexible document data 
-- (like product attributes, reviews, and specs that change per item).
CREATE TABLE product_catalogue_nosql (
    document_id SERIAL PRIMARY KEY,
    product_data JSONB
);

-- 2. INSERT NoSQL DOCUMENTS (JSON format)
-- Notice how different products can have completely different attributes!
INSERT INTO product_catalogue_nosql (product_data) VALUES 
('{
    "product_name": "Smart 4K TV",
    "category": "Electronics",
    "price": 499.99,
    "specs": {
        "screen_size": "55 inches",
        "resolution": "4K Ultra HD",
        "smart_tv": true
    },
    "tags": ["tv", "electronics", "sale"]
}'),
('{
    "product_name": "Running Shoes",
    "category": "Sports",
    "price": 89.99,
    "sizes_available": [7, 8, 9, 10, 11],
    "material": "Breathable mesh"
}');

-- 3. QUERY THE NoSQL JSON DOCUMENTS
-- Find all products in the Electronics category using JSON operators (->>)
SELECT 
    document_id,
    product_data->>'product_name' AS name,
    product_data->>'price' AS price
FROM product_catalogue_nosql
WHERE product_data->>'category' = 'Electronics';

-- 4. ADVANCED QUERY: Search inside nested JSON attributes (Screen Size)
SELECT 
    product_data->>'product_name' AS item,
    product_data['specs']->>'screen_size' AS screen_size
FROM product_catalogue_nosql
WHERE product_data['specs'] IS NOT NULL;