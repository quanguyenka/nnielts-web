# 📚 Documentation Index

Hệ thống tài liệu Claude Session Management cho Votzy.

---

## 🚀 Bắt Đầu (Start Here)

### 1. [QUICK_START.md](QUICK_START.md) ⭐⭐⭐
**Đọc đầu tiên! (2 phút)**
- 3 commands cơ bản
- Emergency save mechanism
- Token savings

**Khi nào đọc:** Lần đầu tiên dùng, cần reference nhanh

---

### 2. [USER_GUIDE.md](USER_GUIDE.md) ⭐⭐⭐
**Hướng dẫn chi tiết! (15 phút)**
- Getting started step-by-step
- Daily workflow với examples
- Emergency save scenarios
- Search & archive
- Troubleshooting
- Real world examples

**Khi nào đọc:** Sau khi đọc QUICK_START, muốn hiểu sâu hơn

---

### 3. [README.md](README.md) ⭐⭐
**Reference documentation (10 phút)**
- Complete feature list
- All commands reference
- Token optimization details
- Best practices
- Technical details

**Khi nào đọc:** Cần reference đầy đủ, hiểu technical details

---

## 📋 Workflow & Guidelines

### 4. [WORKFLOW.md](WORKFLOW.md)
**Workflow guidelines**
- Development workflow
- Team collaboration
- Code review process

**Khi nào đọc:** Cần hiểu workflow của team

---

### 5. [user_preferences.md](user_preferences.md)
**User preferences**
- Personal settings
- Development preferences

**Khi nào đọc:** Setup cá nhân hóa

---

### 6. [SESSION_START_GUIDE.md](SESSION_START_GUIDE.md)
**Session start script guide**
- How to use session_start.sh
- What information is displayed
- Customization options

**Khi nào đọc:** Muốn hiểu session startup process

---

## 🛠️ Configuration

### 7. [settings.local.json](settings.local.json)
**Claude Code configuration**
- Permissions
- Hooks
- Automation

**Khi nào đọc:** Cần customize permissions/hooks

---

## 📁 Templates

### 8. [templates/progress_notes_template.md](templates/progress_notes_template.md)
**Progress notes template**
- Structured format
- Flutter-specific sections

**Khi nào dùng:** Tạo PROGRESS_NOTES.md mới

---

## 🎯 Reading Path

### Path 1: "Tôi muốn bắt đầu ngay!" (5 phút)
```
1. QUICK_START.md (2 phút)
2. Try commands (3 phút)
3. Done!
```

### Path 2: "Tôi muốn hiểu đầy đủ" (30 phút)
```
1. QUICK_START.md (2 phút)
2. USER_GUIDE.md (15 phút)
   - Getting Started
   - Daily Workflow
   - Emergency Save
3. Try commands (10 phút)
4. README.md (optional, 10 phút)
```

### Path 3: "Tôi cần reference cụ thể" (As needed)
```
1. INDEX.md (this file)
2. Jump to specific section:
   - Emergency save → USER_GUIDE.md#emergency-save
   - Search → USER_GUIDE.md#search-find
   - Archive → USER_GUIDE.md#archive-management
   - Troubleshooting → USER_GUIDE.md#troubleshooting
```

---

## 🔍 Quick Links

### Common Tasks

**Bắt đầu session:**
→ [USER_GUIDE.md#daily-workflow](USER_GUIDE.md#daily-workflow)

**Emergency save:**
→ [USER_GUIDE.md#emergency-save](USER_GUIDE.md#emergency-save)

**Tìm work cũ:**
→ [USER_GUIDE.md#search-find](USER_GUIDE.md#search-find)

**Archive sessions:**
→ [USER_GUIDE.md#archive-management](USER_GUIDE.md#archive-management)

**Troubleshooting:**
→ [USER_GUIDE.md#troubleshooting](USER_GUIDE.md#troubleshooting)

**Tips & tricks:**
→ [USER_GUIDE.md#tips-tricks](USER_GUIDE.md#tips-tricks)

**Commands reference:**
→ [README.md#all-commands-cheat-sheet](README.md#all-commands-cheat-sheet)

---

## 📊 Documentation Structure

```
.claude/
├── INDEX.md                          ⭐ This file - Start here
│
├── 🚀 Getting Started
│   ├── QUICK_START.md               ⭐⭐⭐ 3 commands + emergency save
│   └── USER_GUIDE.md                ⭐⭐⭐ Complete step-by-step guide
│
├── 📚 Reference
│   ├── README.md                    ⭐⭐ Full documentation
│   ├── WORKFLOW.md                  Workflow guidelines
│   └── user_preferences.md          User settings
│
├── ⚙️ Configuration
│   └── settings.local.json          Claude Code config
│
└── 📋 Templates
    └── templates/
        └── progress_notes_template.md
```

---

## 💡 Tips

### First Time User?
1. Read **QUICK_START.md** (2 min)
2. Try `smart_context_loader.sh`
3. Read **USER_GUIDE.md** when you have time

### Need Quick Reference?
- **QUICK_START.md** - Commands
- **README.md** - Full reference

### Stuck on Something?
1. Check **USER_GUIDE.md#troubleshooting**
2. Search in docs (grep "problem" *.md)
3. Ask Claude

---

## 🆘 Common Questions

**Q: Tôi nên đọc file nào đầu tiên?**
A: QUICK_START.md (2 phút), sau đó USER_GUIDE.md

**Q: Làm sao emergency save?**
A: Gõ "SAVE NOW" trong conversation, hoặc xem USER_GUIDE.md#emergency-save

**Q: Tìm work cũ thế nào?**
A: `bash .claude/search_sessions.sh "keyword"` - xem USER_GUIDE.md#search-find

**Q: Disk space đầy?**
A: `bash .claude/archive_manager.sh archive` - xem USER_GUIDE.md#archive-management

**Q: Token savings là gì?**
A: Smart loader saves 90% tokens - xem README.md#token-optimization

---

## 📝 Contribution

Nếu bạn thấy docs thiếu gì hoặc cần update:
1. Edit file markdown trực tiếp
2. Update INDEX.md nếu thêm file mới
3. Commit changes

---

## 🎯 Quick Commands

```bash
# Read docs
cat .claude/QUICK_START.md              # Quick start
cat .claude/USER_GUIDE.md               # Full guide
cat .claude/README.md                   # Reference

# Search in docs
grep -r "emergency save" .claude/*.md   # Find specific topic
grep -r "archive" .claude/*.md          # Search keyword

# Open in browser (if markdown viewer installed)
open .claude/USER_GUIDE.md              # macOS
```

---

**Start Reading:** [QUICK_START.md](QUICK_START.md) →

**Version:** 2.0
**Last Updated:** 2025-11-11
**Project:** Votzy (Flutter)
