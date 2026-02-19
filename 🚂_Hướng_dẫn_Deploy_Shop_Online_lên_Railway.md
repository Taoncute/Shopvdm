# 🚂 Hướng dẫn Deploy Shop Online lên Railway

## Bước 1: Đăng ký Railway

1. Truy cập: https://railway.app
2. Click **"Start a New Project"** hoặc **"Login with GitHub"**
3. Đăng nhập bằng GitHub account (miễn phí)

## Bước 2: Tạo Project mới

### Cách 1: Deploy từ GitHub (Khuyến nghị)

1. **Push code lên GitHub:**
   ```bash
   # Tạo repository mới trên GitHub
   # Sau đó chạy:
   cd shop_online
   git remote add origin https://github.com/YOUR_USERNAME/shop-online.git
   git branch -M main
   git push -u origin main
   ```

2. **Deploy trên Railway:**
   - Click **"New Project"**
   - Chọn **"Deploy from GitHub repo"**
   - Chọn repository `shop-online`
   - Railway sẽ tự động detect Dockerfile và build

### Cách 2: Deploy từ file ZIP (Dễ hơn)

1. Download file `shop_online_railway.zip` đã chuẩn bị
2. Giải nén ra thư mục
3. Trên Railway:
   - Click **"New Project"**
   - Chọn **"Deploy from GitHub repo"**
   - Hoặc sử dụng Railway CLI (xem bên dưới)

### Cách 3: Sử dụng Railway CLI (Nhanh nhất)

```bash
# Cài Railway CLI
npm i -g @railway/cli

# Login
railway login

# Deploy
cd shop_online
railway init
railway up
```

## Bước 3: Thêm MySQL Database

1. Trong Railway project của bạn, click **"+ New"**
2. Chọn **"Database"** → **"Add MySQL"**
3. Railway sẽ tự động tạo MySQL instance và inject environment variables:
   - `MYSQLHOST`
   - `MYSQLDATABASE`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`
   - `MYSQLPORT`

## Bước 4: Import Database Schema

### Cách 1: Sử dụng Railway MySQL Client

1. Trong MySQL service, click **"Connect"**
2. Copy connection string
3. Sử dụng MySQL client để import:
   ```bash
   mysql -h MYSQLHOST -P MYSQLPORT -u MYSQLUSER -p MYSQLDATABASE < database.sql
   ```

### Cách 2: Sử dụng phpMyAdmin

1. Deploy phpMyAdmin trên Railway:
   - New Service → Docker Image
   - Image: `phpmyadmin/phpmyadmin`
   - Add environment variables:
     - `PMA_HOST`: MySQL host từ Railway
     - `PMA_PORT`: MySQL port
2. Truy cập phpMyAdmin và import `database.sql`

### Cách 3: Tự động import khi deploy (Đơn giản nhất)

Thêm vào `Dockerfile` (đã có sẵn):
```dockerfile
# Copy database.sql
COPY database.sql /tmp/database.sql

# Import on first run
RUN echo "mysql -h \$MYSQLHOST -P \$MYSQLPORT -u \$MYSQLUSER -p\$MYSQLPASSWORD \$MYSQLDATABASE < /tmp/database.sql" > /docker-entrypoint-initdb.d/init.sh
```

## Bước 5: Cấu hình Environment Variables

Trong Railway project → Settings → Variables, thêm:

### Bắt buộc:
```
# MySQL sẽ tự động có, không cần thêm
MYSQLHOST=auto
MYSQLDATABASE=auto
MYSQLUSER=auto
MYSQLPASSWORD=auto
MYSQLPORT=auto
```

### Tùy chọn (VietQR, Telegram):
```
VIETQR_ACCOUNT_NO=0123456789
VIETQR_ACCOUNT_NAME=NGUYEN VAN A
VIETQR_BANK_ID=VCB

TELEGRAM_BOT_TOKEN=your_bot_token
TELEGRAM_ADMIN_CHAT_ID=your_chat_id

SITE_NAME=Kho Code Của Vanh
```

## Bước 6: Generate Domain và Deploy

1. Railway sẽ tự động build và deploy
2. Sau khi deploy xong, click **"Settings"** → **"Generate Domain"**
3. Railway sẽ cấp domain miễn phí: `your-app.up.railway.app`
4. Truy cập domain để kiểm tra!

## Bước 7: Import Database (Quan trọng!)

Sau khi deploy xong, cần import database:

### Sử dụng Railway CLI:
```bash
railway run mysql -h $MYSQLHOST -P $MYSQLPORT -u $MYSQLUSER -p$MYSQLPASSWORD $MYSQLDATABASE < database.sql
```

### Hoặc kết nối trực tiếp:
1. Lấy MySQL credentials từ Railway
2. Sử dụng MySQL Workbench hoặc TablePlus
3. Import file `database.sql`

## Bước 8: Đăng nhập và sử dụng

1. Truy cập: `https://your-app.up.railway.app`
2. Đăng nhập Admin:
   - Username: `admin`
   - Password: `admin123`
3. **Đổi mật khẩu ngay!**

---

## 🎯 Checklist Deploy

- [ ] Tạo Railway account
- [ ] Tạo project mới
- [ ] Deploy code (GitHub/CLI/ZIP)
- [ ] Thêm MySQL database
- [ ] Import database.sql
- [ ] Cấu hình environment variables (VietQR, Telegram)
- [ ] Generate domain
- [ ] Test website
- [ ] Đăng nhập admin
- [ ] Đổi mật khẩu admin

---

## 🔧 Troubleshooting

### Lỗi: "Connection Error"
→ Kiểm tra MySQL service đã chạy chưa
→ Kiểm tra environment variables

### Lỗi: "500 Internal Server Error"
→ Xem logs: Railway → Deployments → View Logs
→ Kiểm tra database đã import chưa

### Lỗi: "Access denied for user"
→ MySQL credentials không đúng
→ Kiểm tra lại environment variables

### Website không hiển thị CSS
→ Kiểm tra BASE_URL trong Config.php
→ Railway domain phải có HTTPS

---

## 💰 Chi phí

### Railway Free Tier:
- **$5 credit mỗi tháng** (miễn phí)
- Đủ để chạy 1 web app + 1 database nhỏ
- Sau khi hết credit, cần nạp tiền

### Nếu vượt Free Tier:
- Web service: ~$5-10/tháng
- MySQL: ~$5/tháng
- **Tổng: ~$10-15/tháng**

---

## 🚀 Deploy nhanh với Railway CLI

```bash
# Cài Railway CLI
npm i -g @railway/cli

# Đăng nhập
railway login

# Khởi tạo project
cd shop_online
railway init

# Link với MySQL
railway add

# Deploy
railway up

# Xem logs
railway logs

# Mở website
railway open
```

---

## 📝 Lưu ý quan trọng

1. **Đổi mật khẩu admin** ngay sau khi deploy
2. **Backup database** định kỳ
3. **Cấu hình VietQR** với thông tin tài khoản thật
4. **Cấu hình Telegram Bot** để nhận thông báo
5. **Monitor usage** để không vượt free tier

---

## 🎁 Alternative: Deploy lên nền tảng khác

Nếu Railway không phù hợp, có thể deploy lên:

### 1. **Heroku** (Tương tự Railway)
- Free tier: 550 giờ/tháng
- Cần credit card để verify

### 2. **DigitalOcean App Platform**
- $5/tháng cho web app
- $15/tháng cho database

### 3. **VPS tự quản**
- Vultr: $2.5/tháng
- DigitalOcean: $4/tháng
- Linode: $5/tháng

---

## 🆘 Hỗ trợ

Nếu gặp vấn đề khi deploy:
1. Kiểm tra Railway logs
2. Kiểm tra database connection
3. Kiểm tra environment variables
4. Đọc lại hướng dẫn từng bước

**Chúc bạn deploy thành công!** 🎉
