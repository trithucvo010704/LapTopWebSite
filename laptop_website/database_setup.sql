-- =====================================================
-- DATABASE SETUP FOR LAPTOP WEBSITE PROJECT (CHUẨN DOMAIN, AUTO_INCREMENT)
-- =====================================================

-- Tạo database (nếu chưa có)
-- CREATE DATABASE IF NOT EXISTS laptop_website CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE laptop_website;

-- =====================================================
-- 1. TẠO BẢNG ROLES
-- =====================================================
CREATE TABLE IF NOT EXISTS roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- =====================================================
-- 2. TẠO BẢNG USERS
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    user_phone VARCHAR(20),
    address TEXT,
    avatar VARCHAR(255),
    status ENUM('ACTIVE', 'LOCKED', 'INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    role ENUM('ADMIN', 'EDITOR', 'USER') NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- 3. TẠO BẢNG CATEGORY
-- =====================================================
CREATE TABLE IF NOT EXISTS category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- =====================================================
-- 4. TẠO BẢNG PRODUCTS
-- =====================================================
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    image VARCHAR(255),
    detail_desc TEXT,
    short_desc TEXT,
    quantity BIGINT DEFAULT 0,
    sold BIGINT DEFAULT 0,
    factory VARCHAR(100),
    target VARCHAR(100),
    category_id BIGINT,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL
);

-- =====================================================
-- 5. TẠO BẢNG ORDERS
-- =====================================================
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_code VARCHAR(50) UNIQUE NOT NULL,
    total_price DECIMAL(15,2) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'PROCESSING', 'SHIPPING', 'DELIVERED', 'CANCELLED', 'RETURNED') NOT NULL DEFAULT 'PENDING',
    payment_method VARCHAR(50),
    payment_status ENUM('PENDING', 'PAID', 'FAILED', 'REFUNDED') NOT NULL DEFAULT 'PENDING',
    shipping_address TEXT,
    receiver_name VARCHAR(100),
    receiver_phone VARCHAR(20),
    receiver_email VARCHAR(100),
    shipping_fee DECIMAL(15,2) DEFAULT 0.00,
    discount_amount DECIMAL(15,2) DEFAULT 0.00,
    final_price DECIMAL(15,2),
    note TEXT,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- =====================================================
-- 6. TẠO BẢNG ORDER_DETAIL
-- =====================================================
CREATE TABLE IF NOT EXISTS order_detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    quantity BIGINT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    subtotal DECIMAL(15,2),
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- =====================================================
-- 7. DỮ LIỆU MẪU
-- =====================================================
-- 7.1 ROLES
INSERT INTO roles (name, description) VALUES
('ADMIN', 'Quản trị viên hệ thống'),
('EDITOR', 'Biên tập viên'),
('USER', 'Người dùng thông thường');

-- 7.2 USERS
INSERT INTO users (email, password, fullname, user_phone, address, status, role) VALUES
('admin@laptop.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Admin Chính', '0123456789', 'Hà Nội, Việt Nam', 'ACTIVE', 'ADMIN'),
('editor@laptop.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Editor Test', '0987654321', 'TP.HCM, Việt Nam', 'ACTIVE', 'EDITOR'),
('user1@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Nguyễn Văn An', '0901234567', 'Đà Nẵng, Việt Nam', 'ACTIVE', 'USER'),
('user2@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Trần Thị Bình', '0912345678', 'Hải Phòng, Việt Nam', 'ACTIVE', 'USER'),
('user3@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Lê Văn Cường', '0923456789', 'Cần Thơ, Việt Nam', 'LOCKED', 'USER'),
('user4@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Phạm Thị Dung', '0934567890', 'Nha Trang, Việt Nam', 'ACTIVE', 'USER'),
('user5@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'Hoàng Văn Em', '0945678901', 'Vũng Tàu, Việt Nam', 'INACTIVE', 'USER');

-- 7.3 CATEGORY
INSERT INTO category (name, description) VALUES
('Gaming', 'Laptop chuyên cho game thủ'),
('Business', 'Laptop cho doanh nhân'),
('Student', 'Laptop cho học sinh, sinh viên'),
('Ultrabook', 'Laptop mỏng nhẹ, cao cấp'),
('Workstation', 'Laptop cấu hình cao cho kỹ thuật, đồ họa'),
('Professional', 'Laptop chuyên nghiệp');

-- 7.4 PRODUCTS
INSERT INTO products (name, price, image, detail_desc, short_desc, quantity, sold, factory, target, category_id, image_url, is_active) VALUES
('ASUS ROG Strix G15', 25990000, 'rog-strix-g15.jpg', 'Laptop gaming hiệu năng cao với RTX 3060, màn hình 15.6 inch 144Hz', 'Gaming laptop mạnh mẽ', 50, 15, 'ASUS', 'Gaming', 1, '/images/products/rog-strix-g15.jpg', TRUE),
('MSI GE66 Raider', 32990000, 'msi-ge66.jpg', 'Laptop gaming cao cấp với RTX 3070, màn hình 15.6 inch 240Hz', 'Gaming laptop cao cấp', 30, 8, 'MSI', 'Gaming', 1, '/images/products/msi-ge66.jpg', TRUE),
('Lenovo Legion 5', 21990000, 'lenovo-legion-5.jpg', 'Laptop gaming tầm trung với GTX 1650, màn hình 15.6 inch 120Hz', 'Gaming laptop tầm trung', 75, 25, 'Lenovo', 'Gaming', 1, '/images/products/lenovo-legion-5.jpg', TRUE),
('Dell XPS 13', 28990000, 'dell-xps-13.jpg', 'Laptop business cao cấp với Intel i7, màn hình 13.4 inch 4K', 'Business laptop cao cấp', 40, 12, 'Dell', 'Business', 2, '/images/products/dell-xps-13.jpg', TRUE),
('HP EliteBook 840', 18990000, 'hp-elitebook-840.jpg', 'Laptop business với Intel i5, màn hình 14 inch Full HD', 'Business laptop tầm trung', 60, 20, 'HP', 'Business', 2, '/images/products/hp-elitebook-840.jpg', TRUE),
('ThinkPad X1 Carbon', 25990000, 'thinkpad-x1.jpg', 'Laptop business siêu mỏng với Intel i7, màn hình 14 inch 2K', 'Business laptop siêu mỏng', 35, 10, 'Lenovo', 'Business', 2, '/images/products/thinkpad-x1.jpg', TRUE),
('Acer Aspire 5', 15990000, 'acer-aspire-5.jpg', 'Laptop học tập với AMD Ryzen 5, màn hình 15.6 inch Full HD', 'Laptop học tập giá rẻ', 100, 45, 'Acer', 'Student', 3, '/images/products/acer-aspire-5.jpg', TRUE),
('HP Pavilion 15', 17990000, 'hp-pavilion-15.jpg', 'Laptop đa năng với Intel i5, màn hình 15.6 inch Full HD', 'Laptop đa năng', 80, 30, 'HP', 'Student', 3, '/images/products/hp-pavilion-15.jpg', TRUE),
('Lenovo IdeaPad 3', 13990000, 'lenovo-ideapad-3.jpg', 'Laptop cơ bản với Intel i3, màn hình 15.6 inch HD', 'Laptop cơ bản', 120, 60, 'Lenovo', 'Student', 3, '/images/products/lenovo-ideapad-3.jpg', TRUE),
('MacBook Air M1', 25990000, 'macbook-air-m1.jpg', 'Laptop Apple với chip M1, màn hình 13.3 inch Retina', 'Ultrabook Apple', 25, 18, 'Apple', 'Professional', 4, '/images/products/macbook-air-m1.jpg', TRUE),
('Dell XPS 15', 35990000, 'dell-xps-15.jpg', 'Laptop cao cấp với Intel i7, màn hình 15.6 inch 4K OLED', 'Ultrabook cao cấp', 20, 8, 'Dell', 'Professional', 4, '/images/products/dell-xps-15.jpg', TRUE),
('ASUS ZenBook 14', 22990000, 'asus-zenbook-14.jpg', 'Laptop siêu mỏng với Intel i5, màn hình 14 inch Full HD', 'Ultrabook siêu mỏng', 45, 22, 'ASUS', 'Professional', 4, '/images/products/asus-zenbook-14.jpg', TRUE),
('Dell Precision 5550', 45990000, 'dell-precision-5550.jpg', 'Workstation với Intel Xeon, màn hình 15.6 inch 4K', 'Workstation chuyên nghiệp', 15, 5, 'Dell', 'Professional', 5, '/images/products/dell-precision-5550.jpg', TRUE),
('HP ZBook Studio', 39990000, 'hp-zbook-studio.jpg', 'Workstation với Intel i7, màn hình 15.6 inch 4K', 'Workstation cao cấp', 12, 3, 'HP', 'Professional', 5, '/images/products/hp-zbook-studio.jpg', TRUE),
('Old Model Laptop', 9990000, 'old-model.jpg', 'Laptop cũ đã ngừng sản xuất', 'Laptop cũ', 5, 95, 'Unknown', 'Student', 3, '/images/products/old-model.jpg', FALSE);

-- 7.5 ORDERS

-- =========================
-- VÍ DỤ: INSERT 5 ĐƠN HÀNG VỚI NHIỀU SẢN PHẨM
-- =========================

-- Đơn hàng 1
INSERT INTO orders (order_code, total_price, status, payment_method, payment_status, shipping_address, receiver_name, receiver_phone, receiver_email, shipping_fee, discount_amount, final_price, note, user_id)
VALUES ('ORD1001', 25990000, 'PENDING', 'BANK_TRANSFER', 'PENDING', '123 Đường ABC', 'Nguyễn Văn An', '0901234567', 'user1@email.com', 30000, 0, 26020000, 'Giao hàng giờ hành chính', 3);
SET @order_id1 = LAST_INSERT_ID();
INSERT INTO order_detail (quantity, price, subtotal, order_id, product_id)
VALUES (1, 25990000, 25990000, @order_id1, 1);

-- Đơn hàng 2
INSERT INTO orders (order_code, total_price, status, payment_method, payment_status, shipping_address, receiver_name, receiver_phone, receiver_email, shipping_fee, discount_amount, final_price, note, user_id)
VALUES ('ORD1002', 32990000, 'CONFIRMED', 'CREDIT_CARD', 'PAID', '456 Đường XYZ', 'Trần Thị Bình', '0912345678', 'user2@email.com', 30000, 1000000, 32020000, 'Cần giao gấp', 4);
SET @order_id2 = LAST_INSERT_ID();
INSERT INTO order_detail (quantity, price, subtotal, order_id, product_id)
VALUES (1, 32990000, 32990000, @order_id2, 2),
       (2, 15990000, 31980000, @order_id2, 7);

-- Đơn hàng 3
INSERT INTO orders (order_code, total_price, status, payment_method, payment_status, shipping_address, receiver_name, receiver_phone, receiver_email, shipping_fee, discount_amount, final_price, note, user_id)
VALUES ('ORD1003', 21990000, 'DELIVERED', 'CASH', 'PAID', '789 Đường DEF', 'Lê Văn Cường', '0923456789', 'user3@email.com', 30000, 0, 22020000, 'Giao hàng cuối tuần', 5);
SET @order_id3 = LAST_INSERT_ID();
INSERT INTO order_detail (quantity, price, subtotal, order_id, product_id)
VALUES (1, 21990000, 21990000, @order_id3, 3);

-- Đơn hàng 4
INSERT INTO orders (order_code, total_price, status, payment_method, payment_status, shipping_address, receiver_name, receiver_phone, receiver_email, shipping_fee, discount_amount, final_price, note, user_id)
VALUES ('ORD1004', 35990000, 'SHIPPING', 'CASH', 'PAID', '852 Đường BCD', 'Nguyễn Văn An', '0901234567', 'user1@email.com', 30000, 1000000, 35020000, 'Giao hàng đúng hẹn', 3);
SET @order_id4 = LAST_INSERT_ID();
INSERT INTO order_detail (quantity, price, subtotal, order_id, product_id)
VALUES (1, 35990000, 35990000, @order_id4, 11),
       (1, 25990000, 25990000, @order_id4, 1);
-- Đơn hàng 5
INSERT INTO orders (order_code, total_price, status, payment_method, payment_status, shipping_address, receiver_name, receiver_phone, receiver_email, shipping_fee, discount_amount, final_price, note, user_id)
VALUES ('ORD1005', 13990000, 'DELIVERED', 'BANK_TRANSFER', 'PAID', '369 Đường VWX', 'Phạm Thị Dung', '0934567890', 'user4@email.com', 30000, 0, 14020000, 'Đã giao thành công', 6);
SET @order_id5 = LAST_INSERT_ID();
INSERT INTO order_detail (quantity, price, subtotal, order_id, product_id)
VALUES (1, 13990000, 13990000, @order_id5, 9),
       (1, 17990000, 17990000, @order_id5, 8);
-- =========================

-- =====================================================
-- 8. ĐẢM BẢO AUTO_INCREMENT CHO TẤT CẢ BẢNG
-- =====================================================
-- (Đã có trong CREATE TABLE ở trên)

-- =====================================================
-- 9. TẠO INDEXES ĐỂ TỐI ƯU HIỆU SUẤT
-- =====================================================
-- Indexes cho bảng users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Indexes cho bảng products
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_is_active ON products(is_active);
CREATE INDEX idx_products_is_deleted ON products(is_deleted);
CREATE INDEX idx_products_price ON products(price);

-- Indexes cho bảng orders
CREATE INDEX idx_orders_order_code ON orders(order_code);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_payment_status ON orders(payment_status);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_orders_is_deleted ON orders(is_deleted);
CREATE INDEX idx_orders_receiver_name ON orders(receiver_name);

-- Indexes cho bảng order_detail
CREATE INDEX idx_order_detail_order_id ON order_detail(order_id);
CREATE INDEX idx_order_detail_product_id ON order_detail(product_id);

-- =====================================================
-- 10. TẠO VIEWS ĐỂ DỄ DÀNG TRUY VẤN
-- =====================================================
-- View cho đơn hàng chi tiết
CREATE VIEW order_summary AS
SELECT 
    o.id,
    o.order_code,
    o.total_price,
    o.final_price,
    o.status,
    o.payment_status,
    o.receiver_name,
    o.receiver_phone,
    o.created_at,
    u.fullname as customer_name,
    u.email as customer_email,
    COUNT(od.id) as total_items
FROM orders o
LEFT JOIN users u ON o.user_id = u.id
LEFT JOIN order_detail od ON o.id = od.order_id
WHERE o.is_deleted = FALSE
GROUP BY o.id;

-- View cho thống kê sản phẩm
CREATE VIEW product_statistics AS
SELECT 
    p.id,
    p.name,
    p.category_id,
    p.price,
    p.quantity,
    p.sold,
    (p.quantity - p.sold) as available_stock,
    (p.sold * p.price) as total_revenue,
    CASE 
        WHEN p.quantity = 0 THEN 'Hết hàng'
        WHEN p.quantity <= 10 THEN 'Sắp hết'
        ELSE 'Còn hàng'
    END as stock_status
FROM products p
WHERE p.is_deleted = FALSE;

-- =====================================================
-- 11. TẠO STORED PROCEDURES
-- =====================================================
DELIMITER //

-- Procedure để tạo đơn hàng mới
CREATE PROCEDURE CreateOrder(
    IN p_order_code VARCHAR(50),
    IN p_total_price DECIMAL(15,2),
    IN p_user_id BIGINT,
    IN p_receiver_name VARCHAR(100),
    IN p_receiver_phone VARCHAR(20),
    IN p_shipping_address TEXT,
    IN p_shipping_fee DECIMAL(15,2),
    IN p_discount_amount DECIMAL(15,2)
)
BEGIN
    DECLARE v_final_price DECIMAL(15,2);
    
    SET v_final_price = p_total_price + p_shipping_fee - p_discount_amount;
    
    INSERT INTO orders (
        order_code, total_price, user_id, receiver_name, 
        receiver_phone, shipping_address, shipping_fee, 
        discount_amount, final_price, status, payment_status
    ) VALUES (
        p_order_code, p_total_price, p_user_id, p_receiver_name,
        p_receiver_phone, p_shipping_address, p_shipping_fee,
        p_discount_amount, v_final_price, 'PENDING', 'PENDING'
    );
    
    SELECT LAST_INSERT_ID() as order_id;
END //

-- Procedure để cập nhật trạng thái đơn hàng
CREATE PROCEDURE UpdateOrderStatus(
    IN p_order_id BIGINT,
    IN p_status VARCHAR(20)
)
BEGIN
    UPDATE orders 
    SET status = p_status, updated_at = CURRENT_TIMESTAMP
    WHERE id = p_order_id AND is_deleted = FALSE;
    
    SELECT ROW_COUNT() as affected_rows;
END //

-- Procedure để lấy thống kê đơn hàng
CREATE PROCEDURE GetOrderStatistics()
BEGIN
    SELECT 
        COUNT(*) as total_orders,
        COUNT(CASE WHEN status = 'PENDING' THEN 1 END) as pending_orders,
        COUNT(CASE WHEN status = 'CONFIRMED' THEN 1 END) as confirmed_orders,
        COUNT(CASE WHEN status = 'PROCESSING' THEN 1 END) as processing_orders,
        COUNT(CASE WHEN status = 'SHIPPING' THEN 1 END) as shipping_orders,
        COUNT(CASE WHEN status = 'DELIVERED' THEN 1 END) as delivered_orders,
        COUNT(CASE WHEN status = 'CANCELLED' THEN 1 END) as cancelled_orders,
        COUNT(CASE WHEN status = 'RETURNED' THEN 1 END) as returned_orders,
        SUM(CASE WHEN status = 'DELIVERED' AND payment_status = 'PAID' THEN final_price ELSE 0 END) as total_revenue
    FROM orders 
    WHERE is_deleted = FALSE;
END //

DELIMITER ;

-- =====================================================
-- 12. TẠO TRIGGERS
-- =====================================================
DELIMITER //

-- Trigger để tự động tính final_price khi insert/update orders
CREATE TRIGGER before_order_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.final_price IS NULL THEN
        SET NEW.final_price = NEW.total_price + NEW.shipping_fee - NEW.discount_amount;
    END IF;
END //

CREATE TRIGGER before_order_update
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.final_price IS NULL THEN
        SET NEW.final_price = NEW.total_price + NEW.shipping_fee - NEW.discount_amount;
    END IF;
END //

-- Trigger để tự động tính subtotal khi insert/update order_detail
CREATE TRIGGER before_order_detail_insert
BEFORE INSERT ON order_detail
FOR EACH ROW
BEGIN
    IF NEW.subtotal IS NULL THEN
        SET NEW.subtotal = NEW.quantity * NEW.price;
    END IF;
END //

CREATE TRIGGER before_order_detail_update
BEFORE UPDATE ON order_detail
FOR EACH ROW
BEGIN
    IF NEW.subtotal IS NULL THEN
        SET NEW.subtotal = NEW.quantity * NEW.price;
    END IF;
END //

DELIMITER ;

-- =====================================================
-- 13. COMMIT VÀ HOÀN THÀNH
-- =====================================================
COMMIT;

-- Hiển thị thông tin setup
SELECT 'Database setup completed successfully!' as message;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_products FROM products WHERE is_deleted = FALSE;
SELECT COUNT(*) as total_orders FROM orders WHERE is_deleted = FALSE;
SELECT COUNT(*) as total_order_details FROM order_detail;
