Quá trình trao đổi với trợ lý AI trong việc tối ưu hóa cấu trúc CSDL AutoRide:
1. **Kiểu dữ liệu tài chính:**
   - *Prompt:* "Khi thiết kế các cột lưu trữ tiền cọc và phí phạt trong MySQL phục vụ tính toán tài chính, tôi nên dùng kiểu FLOAT hay DECIMAL? Tại sao?"
   - *Kết quả:* AI tư vấn sử dụng kiểu `DECIMAL(10,2)` để tránh hoàn toàn các lỗi sai số dấu phẩy động (floating-point precision error) khi tính toán tiền tệ.
2. **Thiết kế quan hệ bảng kiểm tra xe:**
   - *Prompt:* "Tại sao việc tách dữ liệu kiểm tra xe ra một bảng riêng (Inspections) lại tốt hơn việc nhồi nhét một cột damage_description trực tiếp vào bảng Rentals?"
   - *Kết quả:* AI giải thích theo chuẩn hóa cơ sở dữ liệu (Database Normalization), giúp tránh trùng lặp dữ liệu khi một hợp đồng có thể có nhiều lần kiểm tra hoặc lịch sử ghi nhận chi tiết lỗi theo thời gian.
3. **Ràng buộc khóa ngoại:**
   - *Prompt:* "Cách thiết lập khóa ngoại kèm ràng buộc `ON DELETE RESTRICT` cho bảng Inspections để đảm bảo toàn vẹn dữ liệu?"
   - *Kết quả:* Nhận được cú pháp chuẩn để ràng buộc không cho phép xóa dữ liệu hợp đồng khi đã có biên bản kiểm tra liên quan.
