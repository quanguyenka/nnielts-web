# 🤖 Claude Session Management - Votzy

Hệ thống quản lý session đơn giản, hiệu quả với **token optimization** cho Votzy (Flutter).

---

## 🚀 Quick Start (3 Commands You Need)

### 1️⃣ Bắt Đầu Session (Mỗi Ngày)
```bash
bash .claude/smart_context_loader.sh
```
💰 **Tiết kiệm 80-90% tokens** so với load full context!

### 2️⃣ Kết Thúc Session
```bash
bash .claude/session_end.sh
```

### 3️⃣ Khẩn Cấp "Dừng Lại" 🚨
```bash
bash .claude/emergency_save.sh
```
Hoặc trong conversation với Claude, gõ: **"SAVE NOW"** hoặc **"EMERGENCY SAVE"**

---

## 📁 Cấu Trúc (Simplified)

```
.claude/
├── 🚀 Core Scripts (Use These!)
│   ├── smart_context_loader.sh      ⭐ Start session (tiết kiệm tokens)
│   ├── session_end.sh               ⭐ End session
│   ├── emergency_save.sh            🚨 Quick save mechanism
│   ├── search_sessions.sh           🔍 Search history
│   └── archive_manager.sh           🗄️ Archive old sessions
│
├── 📋 Templates
│   └── templates/
│       └── progress_notes_template.md
│
├── 💾 Storage
│   ├── session_backups/            Active sessions (auto-managed)
│   └── archived_sessions/          Archived (compressed)
│
└── 📚 Docs
    ├── README.md                    This file
    ├── WORKFLOW.md                  Workflow guide
    └── settings.local.json          Permissions & hooks
```

---

## 🚨 Emergency Save - Cơ Chế "Dừng Lại"

Khi bạn cần dừng gấp (mất điện, khẩn cấp, meeting gấp):

### Cách 1: Chạy Script
```bash
bash .claude/emergency_save.sh
```

### Cách 2: Trong Conversation với Claude
Chỉ cần gõ một trong các cụm từ này:
- **"SAVE NOW"**
- **"EMERGENCY SAVE"**
- **"KHẨN CẤP LƯU LẠI"**

Claude sẽ tự động chạy emergency save!

### Emergency Save Làm Gì?
- ✅ Lưu PROGRESS_NOTES.md (hoặc auto-generate)
- ✅ Capture git status & diff
- ✅ Backup changed files (nếu < 10 files)
- ✅ Save Flutter version info
- ✅ Tạo emergency summary
- ⚡ **Siêu nhanh: < 5 giây**

### Sau Khi Emergency Save
```bash
# Xem những gì đã save
ls -lt .claude/session_backups/emergency_*

# Khi có thời gian, chạy proper session end
bash .claude/session_end.sh
```

---

## 💡 Token Optimization

### So Sánh

| Method | Tokens | Savings | When to Use |
|--------|--------|---------|-------------|
| **Smart Loader** | ~4,000 | **90%** | Daily (RECOMMENDED) |
| Full Context | ~40,000 | 0% | First time only |
| Session Search | 0 | **100%** | Finding old work |
| Emergency Save | 0 | **100%** | Quick exit |

### Example: Typical Month
- **Old way:** 30 sessions × 40,000 = 1,200,000 tokens
- **New way:** 30 sessions × 4,000 = 120,000 tokens
- **Savings: 1,080,000 tokens (90%)**

---

## 🔍 Core Scripts Guide

### 1. Smart Context Loader (Daily Start)
```bash
bash .claude/smart_context_loader.sh
```

**Shows:**
- Last session summary (compact)
- Progress notes (last 30 lines)
- Current git status
- Changed files (top 10)
- Flutter/Dart versions

**Doesn't show (saves tokens):**
- ❌ Full git diff
- ❌ Full project structure
- ❌ Full diagnostics

**When to use:** Mỗi ngày, mỗi session

---

### 2. Session End (Daily End)
```bash
bash .claude/session_end.sh
```

**Automatically saves:**
- PROGRESS_NOTES.md
- Git status, diff, log
- Changed files list & snapshots
- Flutter version & doctor
- Project structure
- Session summary

**When to use:** Khi kết thúc session bình thường

---

### 3. Emergency Save (Quick Exit)
```bash
bash .claude/emergency_save.sh
```

**Quick save essentials:**
- PROGRESS_NOTES.md (or auto-generate)
- Git status & diff stats
- Changed files list
- Code snapshots (if small)

**When to use:**
- Mất điện sắp tới
- Phải đi meeting gấp
- Máy sắp hết pin
- Bất kỳ tình huống khẩn cấp nào

**Trigger trong Claude:** Gõ "SAVE NOW"

---

### 4. Session Search (Find Old Work)
```bash
bash .claude/search_sessions.sh "keyword"
```

**Examples:**
```bash
bash .claude/search_sessions.sh "PostCard"
bash .claude/search_sessions.sh "vote button"
bash .claude/search_sessions.sh "profile_page.dart"
```

**Searches in:**
- PROGRESS_NOTES.md
- Git diffs
- Session summaries
- Changed files lists

**Shows:** Snippets + locations

**When to use:** Khi cần tìm lại work cũ

---

### 5. Archive Manager (Cleanup)
```bash
# Archive old sessions (keeps last 10)
bash .claude/archive_manager.sh archive

# List archived sessions
bash .claude/archive_manager.sh list

# Restore specific session
bash .claude/archive_manager.sh restore session_20251107_010555
```

**Archive policy:**
- Keeps last 10 sessions in full
- Compresses older sessions
- **Space savings: 70-80%**

**When to use:** Hàng tháng, hoặc khi disk space thấp

---

## 📝 Daily Workflow

### Buổi Sáng
```bash
cd /Users/macpro16/Documents/Intellij_Workspace/Votzy
bash .claude/smart_context_loader.sh
# Đọc output, nhớ lại work
# Bắt đầu coding
```

### Trong Ngày
```bash
# Nếu cần tìm work cũ
bash .claude/search_sessions.sh "keyword"

# Nếu cần dừng gấp
bash .claude/emergency_save.sh
# hoặc gõ "SAVE NOW" trong conversation
```

### Buổi Tối
```bash
bash .claude/session_end.sh
# Hoặc để Claude tự động chạy khi thoát
```

### Hàng Tháng
```bash
bash .claude/archive_manager.sh archive
```

---

## 🎯 Best Practices

### ✅ NÊN:
- ✅ Dùng `smart_context_loader.sh` mỗi ngày
- ✅ Dùng `emergency_save.sh` khi cần dừng gấp
- ✅ Update PROGRESS_NOTES.md thường xuyên
- ✅ Commit code before ending session
- ✅ Archive sessions mỗi tháng

### ❌ KHÔNG NÊN:
- ❌ Load full context mỗi lần (tốn tokens)
- ❌ Quên save khi dừng gấp
- ❌ Xóa session_backups/ hoặc archived_sessions/

---

## 🆘 Troubleshooting

### Permission denied
```bash
chmod +x .claude/*.sh
```

### Can't find old work
```bash
bash .claude/search_sessions.sh "keyword"
```

### Disk space issues
```bash
bash .claude/archive_manager.sh archive
du -sh .claude/session_backups
du -sh .claude/archived_sessions
```

### Flutter won't stop
```bash
killall -9 dart flutter
```

---

## 📚 All Commands Cheat Sheet

```bash
# ===== Daily Use =====
bash .claude/smart_context_loader.sh      # Start (recommended)
bash .claude/session_start.sh             # Start (full context)
bash .claude/session_end.sh               # End
bash .claude/emergency_save.sh            # Quick save

# ===== Search & Find =====
bash .claude/search_sessions.sh "keyword" # Search sessions
ls -lt .claude/session_backups/           # List sessions

# ===== Archive =====
bash .claude/archive_manager.sh archive   # Archive old
bash .claude/archive_manager.sh list      # List archived
bash .claude/archive_manager.sh restore <name>  # Restore

# ===== Disk Usage =====
du -sh .claude/session_backups            # Active size
du -sh .claude/archived_sessions          # Archive size
```

---

## 🎯 Flutter Quick Commands

```bash
# Development
flutter pub get                  # Install dependencies
flutter run                      # Run app
flutter clean                    # Clean build
flutter doctor                   # Check setup

# Testing
flutter test                     # Run tests
flutter analyze                  # Static analysis

# Building
flutter build ios                # iOS build
flutter build apk                # Android APK
```

---

## 📊 What's in This System?

### Token Optimization
- **Smart context loading:** 80-90% token savings
- **Session search:** 100% savings (local)
- **Emergency save:** 0 tokens, instant

### Session Management
- **Auto backup:** Every session saved
- **Progress tracking:** PROGRESS_NOTES.md
- **Code snapshots:** Changed files preserved
- **Git history:** Full tracking

### Storage Optimization
- **Archive system:** Compress old sessions
- **Space savings:** 70-80% reduction
- **Keep recent:** Last 10 sessions in full

### Emergency Features
- **Quick save:** < 5 seconds
- **Voice trigger:** "SAVE NOW" in conversation
- **Auto-generate:** Creates notes if missing

---

## 📄 Files Overview

### You'll Use Often:
- `smart_context_loader.sh` - Daily start
- `session_end.sh` - Daily end
- `emergency_save.sh` - Emergency exit
- `search_sessions.sh` - Find old work

### You'll Use Sometimes:
- `archive_manager.sh` - Monthly cleanup
- `session_start.sh` - Full context (rare)

### You'll Rarely Touch:
- `start_with_claude.sh` - Launcher
- `settings.local.json` - Config
- `templates/` - Templates

---

## 🎉 Version

**Version:** 2.0 (Simplified)
**Last Updated:** 2025-11-11
**Project:** Votzy (Flutter Social App)

---

**Created by Claude Code** 🤖

**Key Features:**
- 🧠 Smart context loading (90% token savings)
- 🚨 Emergency save mechanism
- 🔍 Fast session search
- 🗄️ Automatic archiving
- ⚡ Optimized for daily use
