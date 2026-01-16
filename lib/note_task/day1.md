Ok 👍
Mình sẽ trả lời lần lượt TẤT CẢ các câu hỏi trong note của bạn, theo kiểu đời thường – đúng bản chất – đúng Flutter, không nói lan man.

⸻

B1 – CÁC CÂU HỎI CỦA BẠN

1️⃣ State là gì?

👉 State = dữ liệu có thể thay đổi trong lúc app đang chạy

Ví dụ:
	•	số đếm
	•	text nhập từ ô input
	•	danh mục đang được chọn
	•	loading / error / success

📌 Khi state đổi → UI vẽ lại

👉 Hiểu đời thường:
	•	State = “tình trạng hiện tại” của màn hình

⸻

2️⃣ Prop là gì?

👉 Prop = dữ liệu được truyền từ bên ngoài vào widget

Ví dụ:
	•	widget con nhận title, color
	•	widget không tự sinh dữ liệu

📌 Prop:
	•	thường là final
	•	đổi bằng cách widget cha truyền giá trị mới

👉 Hiểu đời thường:
	•	Prop = “đồ người khác đưa cho, mình chỉ dùng”

⸻

3️⃣ Tại sao phải sinh ra VÒNG ĐỜI (Lifecycle) của Widget?

👉 Vì widget không tồn tại mãi mãi, nó có:
	•	lúc sinh ra
	•	lúc hiển thị
	•	lúc update
	•	lúc bị huỷ

Nếu không có lifecycle:
	•	không biết khi nào gọi API
	•	không biết khi nào huỷ controller
	•	dễ rò rỉ bộ nhớ

👉 Lifecycle giúp Flutter:
	•	quản lý tài nguyên
	•	tối ưu hiệu năng
	•	tránh bug

⸻

4️⃣ Vòng đời của một Widget (hiểu đúng, dễ nhớ)

Với StatefulWidget
	1.	initState()
👉 widget vừa được tạo
👉 dùng để:

	•	gọi API
	•	init controller
	•	đăng ký listener

	2.	build()
👉 vẽ UI
👉 có thể gọi nhiều lần
	3.	setState()
👉 báo Flutter: “state đổi rồi”
👉 Flutter gọi lại build()
	4.	dispose()
👉 widget bị huỷ
👉 dùng để:

	•	huỷ controller
	•	huỷ stream
	•	dọn rác

📌 KHÔNG gọi API trong build()

⸻

5️⃣ Tại sao phải quản lý vòng đời widget?

👉 Vì nếu không:
	•	gọi API lặp vô hạn
	•	memory leak
	•	crash ngầm

👉 Hiểu đời thường:
	•	vào nhà → bật đèn
	•	ra khỏi nhà → tắt đèn
Không ai để đèn sáng mãi 😄

⸻

6️⃣ Mô hình MVC là gì?

👉 MVC = chia app ra 3 vai
	•	Model: dữ liệu + xử lý
	•	View: giao diện
	•	Controller: điều phối

Luồng:

User → View → Controller → Model → Controller → View

👉 Ưu:
	•	dễ hiểu
👉 Nhược:
	•	app lớn → controller phình to

⸻

7️⃣ Model (freezed) là gì?

👉 Model = cấu trúc dữ liệu

Freezed giúp:
	•	code ngắn
	•	immutable (không tự đổi)
	•	dễ copyWith
	•	dễ parse JSON

👉 Hiểu đời thường:
	•	Model = “form chuẩn để chứa dữ liệu”

⸻

8️⃣ SharedPreferences là gì?

👉 Nơi lưu dữ liệu nhỏ, đơn giản, lâu dài

Ví dụ:
	•	token
	•	dark mode
	•	ngôn ngữ
	•	đã login hay chưa

❌ Không dùng cho:
	•	list lớn
	•	object phức tạp

👉 Hiểu đời thường:
	•	SharedPreferences = “bộ nhớ tạm cá nhân của app”

⸻

9️⃣ Kiến trúc thư mục Flutter là gì?

👉 Cách sắp xếp file & folder cho app

Mục tiêu:
	•	dễ tìm
	•	dễ sửa
	•	dễ mở rộng

📌 Flutter không ép 1 kiểu → bạn chọn cho hợp dự án

⸻

🔟 Tree thư mục Flutter (cách nhìn đúng)

Tree cơ bản:

lib/
├─ main.dart

Tree theo feature (khuyên dùng):

lib/
├─ core/
├─ features/
│  ├─ home/
│  ├─ login/

👉 Mỗi feature tự lo UI + logic + data

⸻

11️⃣ get_it là gì?

👉 get_it = kho giữ instance dùng chung

Dùng để:
	•	không phải new nhiều lần
	•	không phải truyền constructor dài ngoằng

👉 Hiểu đời thường:
	•	get_it = kho trung tâm
	•	instance = đồ trong kho

⸻

12️⃣ Instance là gì?

👉 Instance = 1 object đã được tạo từ class
	•	Class = bản thiết kế
	•	Instance = đồ thật đã tạo

📌 App lớn → phải kiểm soát instance
Không là mỗi nơi 1 bản → bug

⸻

B2 – XÂY DỰNG KIẾN TRÚC DỰ ÁN

👉 Áp dụng:
	•	Clean Architecture
	•	Feature-based
	•	Bloc + get_it

Luồng:

UI → Bloc → UseCase → Repository → DataSource → API


⸻

B3 – CSS (Style) & tích hợp API

CSS trong Flutter:
	•	TextStyle
	•	Theme
	•	ColorScheme

👉 Tách style ra core/theme

Tích hợp API:
	•	Dio
	•	DataSource gọi API
	•	Model parse JSON
	•	Bloc điều khiển state

⸻

✅ TÓM GỌN 1 CÂU CHO CẢ BUỔI 1

Flutter = quản lý state + lifecycle + kiến trúc sạch → UI ổn định

⸻

Nếu bạn muốn:
	•	mình chuyển note này thành tài liệu học hoàn chỉnh
	•	hoặc vẽ sơ đồ tư duy (mindmap)
	•	hoặc hỏi sâu từng mục (ví dụ lifecycle, state vs prop)

Bạn chỉ cần nói 👍