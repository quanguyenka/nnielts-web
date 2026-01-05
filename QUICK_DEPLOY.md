# 🚀 Deploy qua GitHub + Netlify - 5 Bước Đơn Giản

## Bước 1: Tạo GitHub Repository (đã mở sẵn)

Trên trang GitHub mới mở:
1. **Repository name**: `nnielts-web`
2. **Description**: `Landing page for NNielts IELTS center`
3. **Public** ✅ (để dùng Netlify free)
4. **KHÔNG tick** "Initialize with README" ❌
5. Click **"Create repository"** 🎯

---

## Bước 2: Copy Username & Repo URL

Sau khi tạo xong, GitHub sẽ hiện màn hình với commands.

**Lưu lại:**
- Username: `YOUR_USERNAME`
- Repo URL: `https://github.com/YOUR_USERNAME/nnielts-web.git`

---

## Bước 3: Push Code lên GitHub

Cho tôi biết **GitHub username** của bạn, tôi sẽ chạy lệnh push code!

Hoặc bạn có thể tự chạy:

```bash
# Thay YOUR_USERNAME bằng username GitHub của bạn
git remote add origin https://github.com/YOUR_USERNAME/nnielts-web.git
git push -u origin main
```

**Nếu bị hỏi password:**
- Username: (GitHub username)
- Password: (dùng Personal Access Token, KHÔNG phải password)

**Tạo Personal Access Token:**
1. GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token → Chọn "repo" scope → Generate
3. Copy token → Dùng làm password khi push

---

## Bước 4: Connect với Netlify

### 4.1. Vào Netlify
1. Mở: https://app.netlify.com
2. Login (nếu chưa)

### 4.2. Import Project
1. Click **"Add new site"**
2. Click **"Import an existing project"**
3. Click **"Deploy with GitHub"**
4. Authorize Netlify (lần đầu)
5. Chọn repo: **nnielts-web**

### 4.3. Configure Deploy
```
Branch to deploy: main
Base directory: (để trống)
Build command: (để trống)
Publish directory: public  ⬅️ QUAN TRỌNG!
```

### 4.4. Deploy!
Click **"Deploy site"** → Chờ 1-2 phút → Done! 🎉

---

## Bước 5: Lấy URL & Test

Netlify sẽ tạo URL dạng:
```
https://random-name-123456.netlify.app
```

### Custom subdomain (Optional)
Site settings → Domain management → Change site name
→ Đổi thành: `nnielts-center`
→ URL mới: `https://nnielts-center.netlify.app`

---

## 🎯 Sau này khi update code:

```bash
# 1. Edit files trong public/
# 2. Commit
git add .
git commit -m "Update content"

# 3. Push → Tự động deploy!
git push
```

**Netlify tự động deploy mỗi khi push!** ⚡

---

## ❓ Cần giúp?

Nếu bị stuck ở bất kỳ bước nào, báo tôi nhé:
- "Bị lỗi khi push GitHub"
- "Không tìm thấy repo trên Netlify"
- "Deploy failed"

Tôi sẽ giúp debug! 🛠️
