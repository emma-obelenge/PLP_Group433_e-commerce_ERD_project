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
('Nkulenu', 'Ghanaian traditional food products since 1950'),
('Dangote Foods', 'Pan-African food manufacturing company'),
('Okomu Oil', 'Nigerian palm oil and food products'),
('Blue Skies', 'West African fresh and processed foods'),
('Ceres', 'South African fruit juices and products');

-- Insert sample African food categories
INSERT INTO product_category (category_name, parent_category_id, description) VALUES 
('Staples', NULL, 'Basic African food staples'),
('Grains', 1, 'African grains and cereals'),
('Tubers', 1, 'Root crops and tubers'),
('Spices', NULL, 'African herbs and spices'),
('Oils', NULL, 'Traditional African cooking oils'),
('Processed Foods', NULL, 'Ready-to-eat African foods');

-- Insert sample size categories for African foods
INSERT INTO size_category (category_name, description) VALUES 
('Weight', 'Product weight measurements'),
('Volume', 'Liquid volume measurements'),
('Count', 'Piece count for packaged items');

-- Insert sample sizes for African foods
INSERT INTO size_option (size_category_id, size_value, description) VALUES 
(1, '500g', 'Half kilogram package'),
(1, '1kg', 'One kilogram package'),
(1, '5kg', 'Five kilogram bag'),
(2, '250ml', 'Quarter liter bottle'),
(2, '500ml', 'Half liter bottle'),
(2, '1L', 'One liter bottle'),
(3, '12 pieces', 'Dozen package'),
(3, '24 pieces', 'Two dozen package');

-- Insert sample colors for packaging
INSERT INTO color (color_name, hex_code) VALUES 
('Gold', '#FFD700'),
('Green', '#008000'),
('Red', '#FF0000'),
('Black', '#000000'),
('Brown', '#A52A2A');

-- Insert attribute types
INSERT INTO attribute_type (type_name, description) VALUES 
('text', 'Textual attribute'),
('number', 'Numeric attribute'),
('boolean', 'True/False attribute'),
('date', 'Date attribute');

-- Insert attribute categories for African foods
INSERT INTO attribute_category (category_name, description) VALUES 
('Nutrition', 'Nutritional information'),
('Origin', 'Product origin details'),
('Preparation', 'Preparation instructions'),
('Storage', 'Storage requirements');

-- Insert sample African food products
INSERT INTO product (product_name, description, brand_id, category_id, base_price) VALUES 
('Fufu Powder', 'Instant fufu flour from cassava and plantain', 1, 2, 8.99),
('Palm Oil', 'Pure red palm oil for cooking', 3, 5, 6.50),
('Jollof Rice Mix', 'Premium jollof rice seasoning mix', 2, 6, 4.75),
('Suya Spice', 'Authentic Nigerian suya spice blend', 4, 4, 5.25),
('Plantain Chips', 'Crispy ripe plantain chips', 5, 6, 3.99),
('Egusi Seeds', 'High quality melon seeds for soups', 1, 2, 7.50);

-- Insert product variations
INSERT INTO product_variation (product_id, variation_name) VALUES 
(1, 'Original'),
(1, 'Plantain Blend'),
(2, 'Traditional'),
(2, 'Refined'),
(3, 'Mild'),
(3, 'Spicy'),
(4, 'Regular'),
(4, 'Extra Hot'),
(5, 'Sweet'),
(5, 'Spicy');

-- Insert product items with African food variations
INSERT INTO product_item (product_id, variation_id, size_id, color_id, sku, quantity_in_stock, price) VALUES 
(1, 1, 1, 2, 'FUFU500G', 100, 8.99),
(1, 1, 2, 2, 'FUFU1KG', 75, 15.99),
(1, 2, 1, 3, 'FUFUP500G', 60, 9.50),
(2, 3, 4, 3, 'PALM250ML', 120, 3.25),
(2, 3, 5, 3, 'PALM500ML', 90, 6.50),
(3, 5, 1, 1, 'JOLLOF500G', 80, 4.75),
(4, 7, 1, 4, 'SUYA500G', 65, 5.25),
(5, 9, 7, 5, 'CHIPS12', 110, 3.99),
(6, NULL, 2, 2, 'EGUSI1KG', 45, 7.50);

-- Insert product images for African foods
INSERT INTO product_image (product_id, image_url, is_primary) VALUES 
(1, 'Images/fufu-powder.jpg', TRUE),
(1, 'Images/fufu-flour.jpg', FALSE),
(2, 'Images/palm-oil.jpg', TRUE),
(3, 'Images/jollof-mix.jpeg', TRUE),
(4, 'Images/suya-spice.jpg', TRUE),
(5, 'Images/plantain-chips.jpg', TRUE),
(6, 'Images/egusi-seeds.jpg', TRUE);

-- Insert product attributes for African foods
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES 
(1, 1, 2, 'Calories', '350 per 100g'),
(1, 4, 1, 'Storage', 'Keep in cool dry place'),
(2, 2, 1, 'Origin', 'Produced in Nigeria'),
(2, 3, 1, 'Usage', 'For cooking soups and stews'),
(3, 3, 1, 'Preparation', 'Add to rice with tomatoes and onions'),
(4, 2, 1, 'Region', 'Northern Nigeria blend'),
(5, 1, 2, 'Serving Size', 'About 15 chips'),
(6, 3, 1, 'Preparation', 'Grind before use in soups');

