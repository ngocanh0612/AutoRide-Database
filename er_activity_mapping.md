Trong quy trình "Thuê và Trả xe" của AutoRide, việc thiếu hụt các trường dữ liệu tài chính trong thiết kế cũ đã gây ra lỗ hổng nghiêm trọng cho hoạt động kinh doanh:

1. **Sự bắt buộc của cột `damage_fee` và `late_fee`:**
   Theo Activity Diagram, khi trả xe có phát sinh lỗi hư hỏng hoặc trả trễ giờ, hệ thống bắt buộc phải tính toán các khoản phí phát sinh để trừ vào tiền cọc. Nếu không có cột `damage_fee`, kế toán không có cơ sở ghi nhận chi phí đền bù, dẫn đến việc hoàn trả 100% tiền cọc cho khách dù xe bị hỏng, gây thất thoát tài chính lớn cho công ty.

2. **Quản lý trạng thái bằng `ENUM`:**
   Việc thay thế kiểu `VARCHAR` lỏng lẻo bằng `ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED')` giúp khóa chặt vòng đời hợp đồng, ngăn chặn tình trạng dữ liệu trạng thái rác hoặc không hợp lệ.

3. **Sự cần thiết của bảng `Inspections`:**
   Tách biệt biên bản kiểm tra xe thành một bảng riêng giúp lưu vết chi tiết lịch sử kiểm tra, vị trí hư hỏng và tên nhân viên chịu trách nhiệm, đảm bảo tính minh bạch khi xảy ra tranh chấp với khách hàng.
