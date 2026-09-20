BƯỚC 1: Xác định các thực thể có trong mô hình ERD
Dựa trên sơ đồ thực thể kết hợp (ERD), hệ thống gồm 5 thực thể chính:
1. **PHIEUXUAT** (Phiếu xuất)
2. **VATTU** (Vật tư)
3. **PHIEUNHAP** (Phiếu nhập)
4. **DONDH** (Đơn đặt hàng)
5. **NHACCC** (Nhà cung cấp)
BƯỚC 2: Xác định các mối quan hệ (1-1, 1-n, n-m)
* **PHIEUXUAT và VATTU (Quan hệ n - m):** Sinh ra bảng trung gian `ChiTietPhiieuXuat` (Khóa chính: `SoPX`, `MaVTU`; Thuộc tính: `DGXuat`, `SLXuat`).
* **PHIEUNHAP và VATTU (Quan hệ n - m):** Sinh ra bảng trung gian `ChiTietPhiieuNhap` (Khóa chính: `SoPN`, `MaVTU`; Thuộc tính: `DGNhap`, `SLNhap`).
* **DONDH và VATTU (Quan hệ n - m):** Sinh ra bảng trung gian `ChiTietDonDatHang` (Khóa chính: `SoDH`, `MaVTU`).
* **DONDH và NHACCC (Quan hệ n - 1):** Đưa khóa chính `MaNCC` sang làm khóa ngoại trong bảng `DONDH`.
BƯỚC 3: Xác định thuộc tính đa trị
* Các thuộc tính của hệ thống là đơn trị cơ bản. Thuộc tính số điện thoại (`SĐT`) của nhà cung cấp được lưu trữ trực tiếp trong bảng `NHACCC`.
 BƯỚC 4: Liệt kê danh sách các bảng sau khi chuyển đổi
Hệ thống dữ liệu quan hệ thu được gồm tổng cộng 8 bảng:
1. **`PHIEUXUAT`** (Khóa chính: `SoPX`, Thuộc tính: `NgayXuat`)
2. **`VATTU`** (Khóa chính: `MaVTU`, Thuộc tính: `TenVTU`)
3. **`PHIEUNHAP`** (Khóa chính: `SoPN`, Thuộc tính: `NgayNhap`)
4. **`DONDH`** (Khóa chính: `SoDH`, Thuộc tính: `NgayDH`, `MaNCC`)
5. **`NHACCC`** (Khóa chính: `MaNCC`, Thuộc tính: `TenNCC`, `DiChi`, `SDT`)
6. **`ChiTietPhiieuXuat`** (Khóa chính: `SoPX, MaVTU`, Thuộc tính: `DGXuat`, `SLXuat`)
7. **`ChiTietPhiieuNhap`** (Khóa chính: `SoPN, MaVTU`, Thuộc tính: `DGNhap`, `SLNhap`)
8. **`ChiTietDonDatHang`** (Khóa chính: `SoDH, MaVTU`)
