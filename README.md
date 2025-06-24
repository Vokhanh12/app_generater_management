# Tổng quan dự án

Đây là một hệ thống giám sát máy phát điện từ xa qua web. Dữ liệu được thu thập từ các cảm biến trong máy phát và truyền lên hệ thống để:

* Hiển thị biểu đồ thời gian thực (dữ liệu đo lường kỹ thuật).
 
* Theo dõi trạng thái hoạt động của thiết bị (pin, lỗi, kết nối...).

* Hỗ trợ cấu hình từ xa qua giao diện Web.

* Vận hành hiệu quả với chế độ tiết kiệm năng lượng (sleep mode).

* Lưu giữ thông tin ngay cả khi bị mất điện đột ngột.

  
# Dữ liệu hiển thị dạng biểu đồ (Chart)

Nhóm dữ liệu này là các thông số kỹ thuật chính, dùng để theo dõi hoạt động của máy:

```bash
| Địa chỉ (HEX) | Tên biến    | Diễn giải                                 |
| ------------- | ----------- | ----------------------------------------- |
| `1001H`       | `AqBatVol`  | Điện áp của ắc-quy (Volt)                 |
| `1002H`       | `AqChrgVol` | Điện áp đang nạp cho ắc-quy (Volt)        |
| `103BH,103CH` | `ConsCur`   | Dòng điện tiêu thụ (Ampe)                 |
| `1025H`       | `MainL1Vol` | Điện áp pha L1 từ lưới điện (Volt)        |
| `1026H`       | `MainL2Vol` | Điện áp pha L2 từ lưới điện (Volt)        |
| `1027H`       | `MainL3Vol` | Điện áp pha L3 từ lưới điện (Volt)        |
| `1023H`       | `AvrPF`     | Hệ số công suất trung bình (Power Factor) |
```

# Dữ liệu không hiển thị biểu đồ (Card)

Nhóm này là thông tin trạng thái hoặc mô tả, không cần biểu diễn theo biểu đồ:

```bash
| Địa chỉ (nếu có) | Tên biến    | Diễn giải                                                                 |
| ---------------- | ----------- | ------------------------------------------------------------------------- |
| -                | `Ndname`    | Tên node (dạng chữ, không dấu)                                            |
| -                | `NdErrCode` | Mã lỗi (0 là bình thường; 1-255 là lỗi cụ thể)                            |
| -                | `NdBatVol`  | Điện áp của pin 18650                                                     |
| -                | `NdCnctSts` | Trạng thái kết nối (đang kết nối/mất kết nối nếu >20 phút không phản hồi) |
| -                | `NdEleSts`  | Trạng thái điện của node (có điện hay đang dùng pin)                      |
| `1058H`          | `OilLvl`    | Mức dầu còn lại (%)                                                       |
| `1053H`          | `OilPrssr`  | Áp suất dầu (PSI)                                                         |
| `1054H`          | `WtrTemp`   | Nhiệt độ nước làm mát (°C)                                                |
| `1055H`          | `OilTemp`   | Nhiệt độ dầu (°C)                                                         |
| `1036H,1037H`    | `TlRunTime` | Tổng thời gian chạy của máy phát                                          |
```

# Những màn hình

<img width="1710" alt="Screenshot 2025-06-24 at 21 52 33" src="https://github.com/user-attachments/assets/921a380b-7a73-40f2-9202-b84a867dc786" />
<img width="1708" alt="Screenshot 2025-06-24 at 21 52 04" src="https://github.com/user-attachments/assets/0c853fc9-3db3-4b75-b6fe-1a898d53c138" />
<img width="1710" alt="Screenshot 2025-06-24 at 21 51 06" src="https://github.com/user-attachments/assets/02314704-0e1a-481e-911f-6bbba7087aaf" />
<img width="1704" alt="Screenshot 2025-06-24 at 21 31 53" src="https://github.com/user-attachments/assets/a11a2fff-5dcc-4ad2-8ae9-d2532e9d7153" />

