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