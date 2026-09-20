-- HỆ THỐNG AUTORIDE - TỐI ƯU HÓA CSDL
CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- Xóa bảng cũ nếu tồn tại để chạy lại từ đầu
DROP TABLE IF EXISTS Inspections;
DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Cars;

-- 1. Bảng Cars (Quản lý xe)
CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- 2. Bảng Rentals (Quản lý hợp đồng thuê xe - Đã bổ sung trạng thái ENUM và các trường tài chính)
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    
    -- Khóa chặt trạng thái bằng ENUM
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'BOOKED',
    
    -- Bổ sung các cột tài chính dùng kiểu DECIMAL(10,2) để tránh sai số tiền tệ
    security_deposit DECIMAL(10, 2) DEFAULT 0.00,
    late_fee DECIMAL(10, 2) DEFAULT 0.00,
    damage_fee DECIMAL(10, 2) DEFAULT 0.00,
    
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- 3. Bảng Inspections (Biên bản kiểm tra xe khi trả)
CREATE TABLE Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT NOT NULL,
    inspector_name VARCHAR(100),
    
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE RESTRICT
);

-- --- KỊCH BẢN VẬN HÀNH THỰC TẾ (DML) ---

-- Thêm dữ liệu xe mẫu
INSERT INTO Cars (model_name, license_plate) VALUES ('Toyota Vios', '30F-123.45'), ('Mazda 3', '29A-678.90');

-- 1. Khách hàng "Nguyen Van A" thuê xe, đóng cọc 10.000.000 VNĐ. Trạng thái ACTIVE.
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit) 
VALUES (1, 'Nguyen Van A', '2026-06-01 08:00:00', 'ACTIVE', 10000000.00);

-- 2. Khách trả xe, nhân viên kiểm tra phát hiện vỡ đèn pha. Thêm biên bản kiểm tra:
INSERT INTO Inspections (rental_id, damage_description, inspector_name) 
VALUES (1, 'Vỡ đèn pha trái', 'Nhan vien ky thuat Tran B');

-- 3. Cập nhật lại trạng thái hợp đồng: COMPLETED, phí phạt trễ = 0, phí hư hỏng = 2.000.000 VNĐ
UPDATE Rentals 
SET status = 'COMPLETED', 
    return_date = '2026-06-05 10:00:00',
    late_fee = 0.00, 
    damage_fee = 2000000.00 
WHERE rental_id = 1;

-- 4. Truy vấn tính toán số tiền thực tế cần hoàn trả cho khách (Tiền cọc - Phí trễ - Phí sửa chữa)
SELECT 
    rental_id,
    customer_name,
    security_deposit,
    late_fee,
    damage_fee,
    (security_deposit - late_fee - damage_fee) AS refund_amount,
    status
FROM Rentals
WHERE rental_id = 1;
