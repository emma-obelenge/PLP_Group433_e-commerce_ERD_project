-- Creating the database
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Table: brand (African food brands)
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: product_category (African food categories)
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id) ON DELETE SET NULL
);

-- Table: product (African food products)
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES product_category(category_id) ON DELETE SET NULL
);

-- Table: product_image (Images of African food products)
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Table: color (Common colors for African food packaging)
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);

-- Table: size_category (Size categories for African food products)
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

-- Table: size_option (Specific sizes for African food products)
CREATE TABLE size_option (
    size_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT NOT NULL,
    size_value VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id) ON DELETE CASCADE
);

-- Table: attribute_category (Attribute categories for African food)
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Table: attribute_type (Types of attributes for African food)
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Table: product_variation (Variations of African food products)
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    variation_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Table: product_item (Specific items of African food products)
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    variation_id INT,
    size_id INT,
    color_id INT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id) ON DELETE SET NULL,
    FOREIGN KEY (size_id) REFERENCES size_option(size_id) ON DELETE SET NULL,
    FOREIGN KEY (color_id) REFERENCES color(color_id) ON DELETE SET NULL
);

-- Table: product_attribute (Attributes of African food products)
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_category_id INT,
    attribute_type_id INT,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id) ON DELETE SET NULL,
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id) ON DELETE SET NULL
);

-- Insert sample African food brands
INSERT INTO brand (brand_name, description) VALUES
('Tropical Taste', 'Authentic African food brand'),
('Samsung', 'Global electronics manufacturer'),
('Nike', 'Popular athletic clothing brand'),
('Mama’s Pride', 'Homegrown African spice and grain brand'),
('Sony', 'Electronics and entertainment'),
('Adidas', 'Sportswear and accessories'),
('Zara', 'Fast fashion clothing brand'),
('LG', 'Home electronics and appliances'),
('Organic Village', 'African organic food producers'),
('Apple', 'Consumer electronics and software');
-- Sample data for product categories
INSERT INTO product_category (category_name, parent_category_id, description) VALUES
('Food', NULL, 'All food items'),
('Electronics', NULL, 'Electronic items and gadgets'),
('Clothing', NULL, 'Clothing and apparel'),
('Spices', 1, 'African spices and condiments'),
('Grains', 1, 'Staple African grains'),
('Smartphones', 2, 'Mobile phones and accessories'),
('TV & Audio', 2, 'Televisions and audio systems'),
('Men Clothing', 3, 'Menswear'),
('Women Clothing', 3, 'Womenswear'),
('Children Clothing', 3, 'Clothing for children');
--  Sample data for product categories
INSERT INTO product (product_name, description, brand_id, category_id, base_price) VALUES
('Jollof Rice Mix', 'Ready-to-cook Nigerian Jollof rice seasoning', 1, 4, 4.99),
('Samsung Galaxy S21', 'Smartphone with 128GB storage', 2, 6, 799.99),
('Nike Air Max 270', 'Comfortable and stylish sneakers', 3, 8, 149.99),
('Fonio Grain', 'Ancient West African grain, 1kg', 4, 5, 6.49),
('Sony Bravia 55"', '4K Ultra HD Smart LED TV', 5, 7, 699.00),
('Adidas Joggers', 'Men’s sports jogger pants', 6, 8, 59.99),
('Zara Floral Dress', 'Light and flowy summer dress', 7, 9, 39.99),
('LG Bluetooth Speaker', 'Portable audio speaker', 8, 7, 89.50),
('Organic Peanut Butter', 'No preservatives, 500g', 9, 4, 5.29),
('iPhone 13', 'Apple smartphone 128GB', 10, 6, 899.99);
-- Sample data for product images
INSERT INTO product_image (product_id, image_url, is_primary) VALUES
(1, 'images/jollof_mix.jpeg', TRUE),
(2, 'images/galaxy_s21.jpg', TRUE),
(3, 'images/air_max_270.jpg', TRUE),
(4, 'images/fufu-powder.jpg', TRUE),
(5, 'images/sony_bravia.jpg', TRUE),
(6, 'images/adidas_joggers.jpg', TRUE),
(7, 'images/zara_dress.jpg', TRUE),
(8, 'images/lg_speaker.jpg', TRUE),
(9, 'images/palm-oil.jpg', TRUE),
(10, 'images/iphone_13.jpg', TRUE);
-- Sample data for colors
INSERT INTO color (color_name, hex_code) VALUES
('Red', '#FF0000'),
('Black', '#000000'),
('White', '#FFFFFF'),
('Blue', '#0000FF'),
('Green', '#008000'),
('Yellow', '#FFFF00'),
('Grey', '#808080'),
('Orange', '#FFA500'),
('Pink', '#FFC0CB'),
('Brown', '#A52A2A');
--  Sample data for size categories
INSERT INTO size_category (category_name, description) VALUES
('Food Packaging', 'Size for food product packaging'),
('Clothing Size', 'Size for clothing items'),
('Electronics', 'Storage/Screen size options for electronics'),
('Shoes Size', 'Footwear sizing'),
('Bottle Volume', 'Liquid capacity in bottles'),
('Dress Size', 'Dress-specific sizing'),
('Grain Pack Size', 'Grains packaging sizes'),
('Phone Storage', 'Smartphone storage sizes'),
('TV Screen Size', 'Size of TV screens in inches'),
('Speaker Size', 'Portable speaker watt size');
-- Sample data for size options
INSERT INTO size_option (size_category_id, size_value, description) VALUES
(1, '500g', 'Small food packet'),
(1, '1kg', 'Medium food packet'),
(2, 'M', 'Medium clothing size'),
(2, 'L', 'Large clothing size'),
(3, '128GB', 'Storage size for smartphone'),
(4, '42', 'Shoe size EU'),
(5, '750ml', 'Standard bottle'),
(6, 'S', 'Small dress size'),
(7, '2kg', 'Large grain pack'),
(9, '55"', 'Medium TV size');
-- Sample data for attribute categories
INSERT INTO attribute_category (category_name, description) VALUES
('Nutritional Info', 'Nutritional details of food'),
('Storage', 'Storage capacity'),
('Material', 'Material type'),
('Connectivity', 'Type of connectivity'),
('Fabric Type', 'Type of fabric'),
('Battery Life', 'Device battery duration'),
('Display Type', 'TV or phone display'),
('Organic', 'Organic vs processed'),
('Spice Level', 'Heat/spice content'),
('Weight', 'Item weight');
-- Sample data for attribute types
INSERT INTO attribute_type (type_name, description) VALUES
('Text', 'Simple text'),
('Number', 'Numeric value'),
('Boolean', 'True/False value'),
('Dropdown', 'Predefined options'),
('Color', 'Color related value'),
('Percentage', 'Ratio or percentage'),
('Decimal', 'Decimal numbers'),
('Range', 'Min-Max values'),
('URL', 'Web link'),
('Multi-select', 'Multiple choice attributes');
-- Sample data for product variations
INSERT INTO product_variation (product_id, variation_name) VALUES
(1, 'Hot Jollof Mix'),
(1, 'Mild Jollof Mix'),
(2, 'Phantom Black'),
(2, 'Silver'),
(3, 'Black/White'),
(3, 'Red'),
(7, 'Blue Floral'),
(7, 'Green Floral'),
(10, 'Midnight'),
(10, 'Starlight');
-- Sample data for product items
INSERT INTO product_item (product_id, variation_id, size_id, color_id, sku, quantity_in_stock, price) VALUES
(1, 1, 1, 2, 'JLF-HOT-500G-BLK', 30, 4.99),
(1, 2, 2, 3, 'JLF-MLD-1KG-WHT', 25, 5.49),
(2, 3, 5, 1, 'SGS21-BLK-128', 15, 799.99),
(2, 4, 5, 3, 'SGS21-SLV-128', 10, 799.99),
(3, 5, 4, 2, 'NA270-BLK-42', 20, 149.99),
(3, 6, 4, 1, 'NA270-RED-42', 18, 149.99),
(7, 7, 8, 4, 'ZRD-BLU-S', 22, 39.99),
(7, 8, 8, 5, 'ZRD-GRN-S', 19, 39.99),
(10, 9, 5, 2, 'IP13-MID-128', 12, 899.99),
(10, 10, 5, 3, 'IP13-STR-128', 8, 899.99);
-- Sample data for product attributes
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES
(1, 1, 1, 'Calories', '120 per serving'),
(1, 9, 4, 'Spice Level', 'Hot'),
(2, 2, 1, 'Storage', '128GB'),
(2, 4, 1, 'Connectivity', '5G, Wi-Fi 6'),
(3, 3, 1, 'Material', 'Textile & Rubber'),
(7, 5, 1, 'Fabric Type', 'Cotton'),
(9, 8, 3, 'Organic', 'True'),
(5, 7, 1, 'Display Type', 'OLED'),
(5, 6, 1, 'Battery Life', '10 hours'),
(10, 2, 1, 'Storage', '128GB');

-- Top 5 Most Stocked Products
SELECT p.product_name, SUM(pi.quantity_in_stock) AS total_stock
FROM product p
JOIN product_item pi ON p.product_id = pi.product_id
GROUP BY p.product_name
ORDER BY total_stock DESC
LIMIT 5;

-- Product Variants with Low Stock (< 10 units)
SELECT p.product_name, pv.variation_name, pi.sku, pi.quantity_in_stock
FROM product_item pi
JOIN product p ON pi.product_id = p.product_id
JOIN product_variation pv ON pi.variation_id = pv.variation_id
WHERE pi.quantity_in_stock < 10
ORDER BY pi.quantity_in_stock ASC;

-- Average Price of Products by Category
SELECT pc.category_name, ROUND(AVG(p.base_price), 2) AS avg_price
FROM product p
JOIN product_category pc ON p.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY avg_price DESC;