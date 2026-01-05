# ⚡ Quick Start - Votzy Session Management

## 🎯 3 Commands You Need to Know

### 1. Start Session
```bash
bash .claude/smart_context_loader.sh
```
💰 Saves 90% tokens!

### 2. End Session
```bash
bash .claude/session_end.sh
```

### 3. Emergency Save 🚨
```bash
bash .claude/emergency_save.sh
```
Or just type in conversation: **"SAVE NOW"**

---

## 🚨 Cơ Chế "Dừng Lại"

Khi cần dừng gấp, chỉ cần:

### Option 1: Gõ trong conversation
```
SAVE NOW
```
hoặc
```
EMERGENCY SAVE
```

Claude sẽ tự động chạy emergency save!

### Option 2: Chạy script trực tiếp
```bash
bash .claude/emergency_save.sh
```

### Khi nào dùng?
- ⚡ Mất điện sắp tới
- 💼 Phải đi meeting gấp
- 🔋 Máy sắp hết pin
- 🚨 Bất kỳ tình huống khẩn cấp nào

### Emergency save làm gì?
- ✅ Lưu PROGRESS_NOTES.md (hoặc auto-generate)
- ✅ Capture git status & changes
- ✅ Backup changed files (nếu ít)
- ⚡ **Siêu nhanh: < 5 giây**

---

## 📁 Core Scripts (Chỉ 5 Files)

```
.claude/
├── smart_context_loader.sh    ⭐ Daily start (saves tokens)
├── session_end.sh             ⭐ Daily end
├── emergency_save.sh          🚨 Quick save
├── search_sessions.sh         🔍 Find old work
└── archive_manager.sh         🗄️ Cleanup (monthly)
```

---

## 💡 Token Savings

| What | Before | After | Saved |
|------|--------|-------|-------|
| Daily start | 40,000 | 4,000 | **90%** |
| Monthly (30 days) | 1.2M | 120K | **90%** |

---

## 🔍 Other Useful Commands

### Find old work
```bash
bash .claude/search_sessions.sh "keyword"
```

### Archive old sessions (monthly)
```bash
bash .claude/archive_manager.sh archive
```

### List archives
```bash
bash .claude/archive_manager.sh list
```

---

## 📖 Full Documentation

Read **README.md** for complete details:
```bash
cat .claude/README.md
```

---

**Version:** 2.0 (Simplified)
**Project:** Votzy (Flutter)
