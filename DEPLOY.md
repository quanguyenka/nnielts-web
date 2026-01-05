# 🚀 Hướng dẫn Deploy lên Netlify

## Phương pháp 1: Drag & Drop (Dễ nhất - 2 phút) ⭐

### Bước 1: Chuẩn bị
```bash
# Mở thư mục public trong Finder
cd /Users/macpro16/Documents/Intellij_Workspace/nnielts-web
open public
```

### Bước 2: Deploy
1. Mở [https://app.netlify.com/drop](https://app.netlify.com/drop)
2. **Kéo thả** toàn bộ nội dung thư mục `public/` vào
3. Chờ 30 giây → Website live! 🎉

### Bước 3: Custom domain (Optional)
- Site settings → Domain management → Add custom domain

---

## Phương pháp 2: GitHub + Netlify (Auto deploy)

### Bước 1: Push lên GitHub
```bash
# Tạo repo mới trên GitHub, sau đó:
git remote add origin https://github.com/YOUR_USERNAME/nnielts-web.git
git push -u origin main
```

### Bước 2: Connect Netlify
1. Vào [https://app.netlify.com](https://app.netlify.com)
2. Click "Add new site" → "Import an existing project"
3. Chọn GitHub → Authorize → Chọn repo `nnielts-web`
4. Settings:
   - **Branch to deploy**: `main`
   - **Publish directory**: `public`
   - **Build command**: (để trống)
5. Click "Deploy site"

### Lợi ích:
✅ Tự động deploy khi push code mới
✅ Preview deploys cho mỗi pull request
✅ Rollback dễ dàng

---

## Phương pháp 3: Netlify CLI (Nâng cao)

### Bước 1: Cài đặt
```bash
npm install -g netlify-cli
```

### Bước 2: Login
```bash
netlify login
```

### Bước 3: Deploy
```bash
# Deploy lần đầu
netlify deploy

# Xem preview, nếu OK thì:
netlify deploy --prod
```

---

## 🎯 Sau khi deploy thành công

Bạn sẽ nhận được URL dạng:
```
https://random-name-123456.netlify.app
```

### Custom domain:
1. Site settings → Domain management
2. Add custom domain → Nhập tên miền của bạn
3. Cập nhật DNS records theo hướng dẫn

### Cấu hình đã tự động:
✅ HTTPS/SSL certificate
✅ CDN global
✅ Continuous deployment
✅ Form handling
✅ Cache headers

---

## 📊 Performance Tips

Website đã được optimize:
- ✅ Minify CSS/JS (tự động bởi Netlify)
- ✅ Image optimization (Netlify Image CDN)
- ✅ Gzip compression (tự động)
- ✅ HTTP/2 (tự động)
- ✅ CDN caching (headers đã config)

---

## 🔧 Troubleshooting

### Lỗi: Page not found
→ Check `netlify.toml` có đúng `publish = "public"`

### Lỗi: CSS/JS không load
→ Check đường dẫn trong HTML (phải relative paths)

### Deploy lâu
→ Netlify free tier: 300 minutes/month, đủ dùng!

---

## 🎉 Next Steps

Sau khi deploy:
1. Test website trên mobile
2. Check Lighthouse score
3. Add Google Analytics
4. Submit lên Google Search Console
5. Share URL với team!

---

**Quick Deploy**: [https://app.netlify.com/drop](https://app.netlify.com/drop)
