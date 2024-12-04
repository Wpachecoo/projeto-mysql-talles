CREATE TABLE categories (
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  description TEXT,
  category_type ENUM('FOOD', 'DRINK', 'OTHER') NOT NULL,
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 
CREATE TABLE addresses (
  address_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  address_type ENUM('HOME', 'WORK', 'OTHER') NOT NULL,
  street VARCHAR(255),
  street_number VARCHAR(10),
  neighborhood VARCHAR(100),
  city VARCHAR(100),
  state CHAR(2),
  zip_code VARCHAR(15),
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 
CREATE TABLE payment_methods (
  payment_method_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  method_name VARCHAR(100) NOT NULL,
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 
CREATE TABLE establishments (
  establishment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  phone VARCHAR(20),
  category_id BIGINT NOT NULL,
  address_id BIGINT NOT NULL,
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories (category_id),
  FOREIGN KEY (address_id) REFERENCES addresses (address_id)
);
 
CREATE TABLE products (
  product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  establishment_id BIGINT NOT NULL,
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (establishment_id) REFERENCES establishments (establishment_id)
);
 
CREATE TABLE additional_items (
  additional_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  establishment_id BIGINT NOT NULL,
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (establishment_id) REFERENCES establishments (establishment_id)
);
 
CREATE TABLE orders (
  order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  total_value DECIMAL(10,2),
  delivery_address_id BIGINT,
  order_status ENUM('PENDING', 'COMPLETED', 'CANCELED') DEFAULT 'PENDING',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (delivery_address_id) REFERENCES addresses (address_id)
);
 
CREATE TABLE order_items (
  order_item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (product_id) REFERENCES products (product_id)
);
 
CREATE TABLE payments (
  payment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  payment_method_id BIGINT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payment_status ENUM('PENDING', 'CONFIRMED', 'FAILED') DEFAULT 'PENDING',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods (payment_method_id)
);
 
CREATE TABLE reviews (
  review_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  establishment_id BIGINT NOT NULL,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (establishment_id) REFERENCES establishments (establishment_id)
);
-- Inserindo dados na tabela categories
INSERT INTO categories (name, description, category_type, status)
VALUES 
('Restaurantes', 'Comidas variadas', 'FOOD', 'ACTIVE'),
('Bares', 'Bebidas e aperitivos', 'DRINK', 'ACTIVE'),
('Outros', 'Serviços diversos', 'OTHER', 'ACTIVE');

-- Inserindo dados na tabela addresses
INSERT INTO addresses (address_type, street, street_number, neighborhood, city, state, zip_code, status)
VALUES 
('HOME', 'Rua das Flores', '123', 'Centro', 'São Paulo', 'SP', '01000-000', 'ACTIVE'),
('WORK', 'Avenida Paulista', '1000', 'Bela Vista', 'São Paulo', 'SP', '01310-000', 'ACTIVE'),
('OTHER', 'Praça da Liberdade', '50', 'Liberdade', 'São Paulo', 'SP', '01503-010', 'ACTIVE');

-- Inserindo dados na tabela payment_methods
INSERT INTO payment_methods (method_name, status)
VALUES 
('Cartão de Crédito', 'ACTIVE'),
('Dinheiro', 'ACTIVE'),
('Pix', 'ACTIVE');

-- Inserindo dados na tabela establishments
INSERT INTO establishments (name, phone, category_id, address_id, status)
VALUES 
('Restaurante Bom Gosto', '1122334455', 1, 1, 'ACTIVE'),
('Bar dos Amigos', '5566778899', 2, 2, 'ACTIVE');

-- Inserindo dados na tabela products
INSERT INTO products (name, description, price, establishment_id, status)
VALUES 
('Hambúrguer Especial', 'Delicioso hambúrguer artesanal', 25.90, 1, 'ACTIVE'),
('Caipirinha', 'Bebida típica brasileira', 15.00, 2, 'ACTIVE');

-- Inserindo dados na tabela additional_items
INSERT INTO additional_items (name, price, establishment_id, status)
VALUES 
('Queijo extra', 3.50, 1, 'ACTIVE'),
('Gelo adicional', 1.00, 2, 'ACTIVE');

-- Inserindo dados na tabela orders
INSERT INTO orders (total_value, delivery_address_id, order_status)
VALUES 
(50.90, 1, 'PENDING'),
(30.00, 2, 'PENDING');

-- Inserindo dados na tabela order_items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price)
VALUES 
(1, 1, 2, 25.90, 51.80),
(2, 2, 2, 15.00, 30.00);

-- Inserindo dados na tabela payments
INSERT INTO payments (order_id, payment_method_id, amount, payment_status)
VALUES 
(1, 1, 51.80, 'PENDING'),
(2, 3, 30.00, 'CONFIRMED');

-- Inserindo dados na tabela reviews
INSERT INTO reviews (order_id, establishment_id, rating, comment, status)
VALUES 
(1, 1, 5, 'Excelente hambúrguer!', 'ACTIVE'),
(2, 2, 4, 'Caipirinha boa, mas poderia ser mais forte.', 'ACTIVE');	