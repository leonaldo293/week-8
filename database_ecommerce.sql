
CREATE DATABASE IF NOT EXISTS ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_db;

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(30),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE addresses (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100),
  postal_code VARCHAR(20),
  country VARCHAR(100) NOT NULL,
  is_billing BOOLEAN DEFAULT FALSE,
  is_shipping BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);


CREATE TABLE productlines (
  productline_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);


CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(200) NOT NULL,
  product_vendor VARCHAR(150),
  productline_id INT,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  stock INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (productline_id) REFERENCES productlines(productline_id) ON DELETE SET NULL
);


CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  shipped_date DATETIME NULL,
  status VARCHAR(50) NOT NULL DEFAULT 'Pending',
  shipping_address_id INT NULL,
  billing_address_id INT NULL,
  total_amount DECIMAL(12,2) DEFAULT 0.00,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
  FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id) ON DELETE SET NULL,
  FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id) ON DELETE SET NULL
);


CREATE TABLE order_items (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);


CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  amount DECIMAL(12,2) NOT NULL,
  method VARCHAR(50),
  transaction_ref VARCHAR(200),
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);


CREATE INDEX idx_products_productline ON products(productline_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);


INSERT INTO productlines (name, description) VALUES
('Laptops', 'Portable computers'),
('Accessories', 'Computer accessories and peripherals'),
('Phones', 'Mobile phones and accessories');

INSERT INTO products (product_name, product_vendor, productline_id, price, stock) VALUES
('UltraBook X1', 'BrandA', 1, 1299.00, 10),
('Gaming Mouse Pro', 'PeriphCo', 2, 49.99, 200),
('SmartPhone Z', 'PhoneInc', 3, 799.00, 50);

INSERT INTO customers (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '+244912345678'),
('Jane', 'Smith', 'jane.smith@example.com', '+244987654321');

INSERT INTO addresses (customer_id, street, city, state, postal_code, country, is_billing, is_shipping) VALUES
(1, 'Av. Exemplo 123', 'Luanda', 'Luanda', '1000', 'Angola', TRUE, TRUE),
(2, 'Rua Teste 45', 'Luanda', 'Luanda', '2000', 'Angola', TRUE, TRUE);


INSERT INTO orders (customer_id, status, shipping_address_id, billing_address_id, total_amount)
VALUES (1, 'Processing', 1, 1, 128.33);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(LAST_INSERT_ID(), 1, 1, 1212.55); 

