# 🚀 Deploy qua GitHub + Netlify (Auto Deploy)

## ✨ Lợi ích:
- ✅ Tự động deploy khi push code mới
- ✅ Preview deploy cho mỗi commit
- ✅ Dễ dàng rollback về version cũ
- ✅ Collaborate với team dễ dàng
- ✅ Free 100% cho public repo

---

## Bước 1: Tạo GitHub Repository

### Cách 1: Qua GitHub CLI (nhanh)
```bash
# Cài GitHub CLI (nếu chưa có)
brew install gh

# Login
gh auth login

# Tạo repo và push
gh repo create nnielts-web --public --source=. --remote=origin --push
```

### Cách 2: Qua Web UI
1. Mở https://github.com/new
2. Repository name: `nnielts-web`
3. Description: "Landing page for NNielts IELTS center"
4. Chọn: **Public** (để dùng Netlify free)
5. **KHÔNG chọn**: Initialize with README (vì đã có rồi)
6. Click **Create repository**

---

## Bước 2: Push Code lên GitHub

```bash
# Add remote (thay YOUR_USERNAME bằng username GitHub của bạn)
git remote add origin https://github.com/YOUR_USERNAME/nnielts-web.git

# Push lên GitHub
git push -u origin main

# Nếu bị lỗi authentication:
git remote set-url origin https://YOUR_USERNAME@github.com/YOUR_USERNAME/nnielts-web.git
git push -u origin main
```

**Hoặc dùng SSH (recommend):**
```bash
# Setup SSH key (nếu chưa có)
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub
# Copy key → GitHub Settings → SSH Keys → Add new

# Add remote với SSH
git remote add origin git@github.com:YOUR_USERNAME/nnielts-web.git
git push -u origin main
```

---

## Bước 3: Connect GitHub với Netlify

### A. Qua Web UI (Dễ nhất)

1. **Mở Netlify**
   - https://app.netlify.com

2. **Import project**
   - Click "Add new site" → "Import an existing project"

3. **Connect to Git provider**
   - Click "GitHub"
   - Authorize Netlify (lần đầu)
   - Chọn repository: `nnielts-web`

4. **Deploy settings**
   ```
   Branch to deploy: main
   Base directory: (để trống)
   Build command: (để trống)
   Publish directory: public
   ```

5. **Deploy!**
   - Click "Deploy site"
   - Chờ 1-2 phút
   - Done! 🎉

### B. Qua Netlify CLI

```bash
# Cài Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Link repo với Netlify
netlify init

# Chọn:
# - Create & configure a new site
# - Your team
# - Site name: nnielts-web (hoặc để Netlify tự gen)
# - Build command: (để trống)
# - Publish directory: public

# Done! Auto deploy đã được setup
```

---

## Bước 4: Verify Deployment

Sau khi deploy xong, bạn sẽ có:

### 🌐 Production URL
```
https://nnielts-web.netlify.app
```
Hoặc tên random nếu không đặt custom name

### 🔗 GitHub Integration
- Mỗi commit → auto build
- Pull request → preview deploy
- Main branch → production deploy

### 📊 Netlify Dashboard
- Build logs
- Deploy history
- Analytics
- Forms submissions

---

## 🎯 Workflow sau này

```bash
# 1. Edit code
vim public/index.html

# 2. Commit
git add .
git commit -m "Update homepage content"

# 3. Push → Auto deploy!
git push

# 4. Check deploy status
netlify status
# Hoặc xem trên: https://app.netlify.com
```

**Deploy tự động diễn ra trong 1-2 phút!** ⚡

---

## 🎨 Custom Domain (Optional)

### Netlify subdomain (Free)
```bash
netlify sites:update --name nnielts-center
# URL: https://nnielts-center.netlify.app
```

### Custom domain (nnielts.com)
1. Netlify Dashboard → Domain settings
2. Add custom domain → nhập `nnielts.com`
3. Cập nhật DNS records:
   ```
   Type    Name    Value
   A       @       75.2.60.5
   CNAME   www     nnielts-center.netlify.app
   ```
4. Netlify tự động enable HTTPS/SSL

---

## 🔧 Advanced: Deploy Previews

### Branch deploys
```bash
# Tạo branch mới
git checkout -b feature/new-section

# Push branch
git push origin feature/new-section

# Netlify tự động tạo preview URL:
# https://feature-new-section--nnielts-web.netlify.app
```

### Deploy contexts trong netlify.toml
```toml
[context.production]
  command = ""
  publish = "public"

[context.deploy-preview]
  command = ""
  publish = "public"

[context.branch-deploy]
  command = ""
  publish = "public"
```

---

## 📊 Monitoring

### Build status badge
Thêm vào README.md:
```markdown
[![Netlify Status](https://api.netlify.com/api/v1/badges/YOUR-SITE-ID/deploy-status)](https://app.netlify.com/sites/YOUR-SITE-NAME/deploys)
```

### Notifications
- Netlify Dashboard → Notifications
- Connect với Slack/Discord/Email

---

## 🐛 Troubleshooting

### Lỗi: Repository not found
→ Check permissions: GitHub Settings → Applications → Netlify → Grant access

### Lỗi: Build failed
→ Check netlify.toml config & publish directory

### Lỗi: Cannot push to GitHub
→ Check authentication: `gh auth status` hoặc setup SSH key

### Deploy chậm
→ Kiểm tra Netlify status: https://netlifystatus.com

---

## 🎉 Xong!

Sau khi setup xong, bạn chỉ cần:
```bash
git add .
git commit -m "Update"
git push
```

Netlify tự động deploy! 🚀

---

**Quick Links:**
- GitHub: https://github.com/YOUR_USERNAME/nnielts-web
- Netlify: https://app.netlify.com
- Live site: https://nnielts-web.netlify.app
