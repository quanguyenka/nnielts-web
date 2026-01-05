# 📖 Hướng Dẫn Sử Dụng Claude Session Management

Hướng dẫn chi tiết, từng bước cho hệ thống quản lý session của Votzy.

---

## 📚 Mục Lục

1. [Getting Started](#getting-started)
2. [Daily Workflow](#daily-workflow)
3. [Emergency Save - Dừng Khẩn Cấp](#emergency-save)
4. [Search & Find Old Work](#search-find)
5. [Archive Management](#archive-management)
6. [Troubleshooting](#troubleshooting)
7. [Tips & Tricks](#tips-tricks)
8. [Real World Examples](#examples)

---

## 🚀 Getting Started {#getting-started}

### Lần Đầu Tiên Setup

**Bước 1: Kiểm tra scripts có executable không**
```bash
cd /Users/macpro16/Documents/Intellij_Workspace/Votzy/.claude
ls -l *.sh
```

Nếu không có `x` (execute permission), chạy:
```bash
chmod +x *.sh
```

**Bước 2: Test smart context loader**
```bash
bash smart_context_loader.sh
```

Bạn sẽ thấy output như:
```
🧠 Smart Context Loader - Votzy
================================
📂 Latest session: session_20251107_010555

📊 Session Summary (compact):
...

✨ Context loaded efficiently! (Token savings: ~80-90%)
```

**Bước 3: Done!** Bạn đã sẵn sàng sử dụng.

---

## 📅 Daily Workflow {#daily-workflow}

### 🌅 Buổi Sáng - Bắt Đầu Session

#### Scenario: Bạn mở máy tính, muốn tiếp tục code Votzy

**Bước 1: Mở Terminal**
```bash
cd /Users/macpro16/Documents/Intellij_Workspace/Votzy
```

**Bước 2: Load context (Smart mode - Recommended)**
```bash
bash .claude/smart_context_loader.sh
```

**Output bạn sẽ thấy:**
```
🧠 Smart Context Loader - Votzy
================================
📂 Latest session: session_20251107_010555

📊 Session Summary (compact):
Files Changed: 4
Files Backed Up: 4
Insertions: 127
Deletions: 45

📝 Progress Notes (last 30 lines):
## ✅ Completed
### Feature: PostCard Widget Update
- Fixed AppBar title overlap issue
- Updated padding and layout
...

📊 Current Git Status:
M mobile/lib/features/feed/presentation/widgets/post_card.dart
M mobile/lib/core/theme/app_theme.dart

🔄 Changed Files (2):
mobile/lib/features/feed/presentation/widgets/post_card.dart
mobile/lib/core/theme/app_theme.dart

📈 Change Statistics:
2 files changed, 15 insertions(+), 8 deletions(-)

🔍 Environment:
   Flutter: 3.35.7
   Dart: 3.9.2

✅ No Flutter processes running

💡 Tips:
   • Full git diff: .claude/session_backups/session_20251107_010555/git_diff_full.txt
   • Code snapshots: .claude/session_backups/session_20251107_010555/code_snapshot/
   • Full context: bash .claude/session_start.sh
   • Search sessions: bash .claude/search_sessions.sh <keyword>

================================
✨ Context loaded efficiently! (Token savings: ~80-90%)
```

**Bước 3: Đọc output và nhớ lại**
- Bạn đã làm gì session trước (Progress Notes)
- Files nào đang thay đổi (Changed Files)
- Environment status (Flutter/Dart versions)

**Bước 4: Bắt đầu code với Claude**
Mở Claude Code và bắt đầu request:
```
"Hãy tiếp tục implement PostCard widget, tôi muốn thêm animation khi tap"
```

---

### 🕐 Trong Ngày - Làm Việc Bình Thường

#### Scenario 1: Bạn nhớ làm gì đó về "vote button" tuần trước

**Tìm kiếm nhanh:**
```bash
bash .claude/search_sessions.sh "vote button"
```

**Output:**
```
🔍 Searching sessions for: vote button
================================

📁 session_20251105_081425
   Found in: progress_notes git_diff changed_files
   Snippet:
      ## Vote Button Enhancement
      - Added haptic feedback
      - Updated animation duration
   Location: .claude/session_backups/session_20251105_081425

📁 session_20251104_175253
   Found in: git_diff
   Location: .claude/session_backups/session_20251104_175253

================================
✨ Found in 2 session(s)
```

**Xem chi tiết:**
```bash
# Xem progress notes của session tìm được
cat .claude/session_backups/session_20251105_081425/PROGRESS_NOTES.md

# Hoặc xem git diff
cat .claude/session_backups/session_20251105_081425/git_diff_full.txt | less
```

---

#### Scenario 2: Bạn muốn xem code cũ của một file

**Xem code snapshot:**
```bash
# Tìm session có file đó
bash .claude/search_sessions.sh "vote_button.dart"

# Xem code snapshot
cat .claude/session_backups/session_20251105_081425/code_snapshot/mobile/lib/features/voting/presentation/widgets/vote_button.dart
```

---

### 🌆 Buổi Tối - Kết Thúc Session

#### Scenario: Bạn đã code xong, muốn kết thúc session

**Bước 1: (Optional) Update PROGRESS_NOTES.md**
```bash
# Nếu chưa có, tạo từ template
cp .claude/templates/progress_notes_template.md PROGRESS_NOTES.md
nano PROGRESS_NOTES.md  # hoặc code/vim
```

Hoặc yêu cầu Claude:
```
"Hãy tạo PROGRESS_NOTES.md với những gì chúng ta đã làm hôm nay"
```

**Bước 2: End session**
```bash
bash .claude/session_end.sh
```

**Output:**
```
🔄 Saving session state...
📁 Creating session folder: .claude/session_backups/session_20251111_180000
  ✅ Backed up PROGRESS_NOTES.md
  📊 Saving git status...
  💾 Backing up changed code files...
  ✅ Backed up 4 changed files
  📱 Saving Flutter info...

✅ Session backup completed!

📁 Backup location: .claude/session_backups/session_20251111_180000

📊 Summary:
- Files changed: 4
- Files backed up: 4
- Insertions: 127
- Deletions: 45

🔧 Next session:
   cd /Users/macpro16/Documents/Intellij_Workspace/Votzy
   bash .claude/session_start.sh
   flutter pub get
   flutter run
```

**Bước 3: Done!** Tất cả đã được lưu.

---

## 🚨 Emergency Save - Dừng Khẩn Cấp {#emergency-save}

### Khi Nào Dùng Emergency Save?

- ⚡ **Mất điện sắp tới** (laptop sắp hết pin, điện sập)
- 💼 **Phải đi meeting gấp** (sếp gọi ngay)
- 🏃 **Phải đi đâu gấp** (taxi đã tới)
- 🔥 **Tình huống khẩn cấp bất ngờ**
- 🐛 **Build lỗi nghiêm trọng** (cần save trước khi rollback)

### Cách 1: Gõ trong Conversation với Claude (RECOMMENDED)

**Chỉ cần gõ:**
```
SAVE NOW
```

Hoặc:
```
EMERGENCY SAVE
```

Hoặc:
```
KHẨN CẤP LƯU LẠI
```

**Claude sẽ tự động:**
1. Detect keyword
2. Chạy `bash .claude/emergency_save.sh`
3. Báo cho bạn khi xong

**Ví dụ conversation:**
```
You: Tôi đang implement animation cho PostCard...

[Laptop pin 2%]

You: SAVE NOW

Claude: 🚨 Emergency save detected! Running emergency_save.sh...

🚨 EMERGENCY SAVE ACTIVATED
================================
📊 Capturing current state...
✅ Saved PROGRESS_NOTES.md
✅ Saved git status
✅ Saved git diff stats
✅ Saved changed files list (4 files)
✅ Saved code snapshots
✅ Saved Flutter version

================================
✅ EMERGENCY SAVE COMPLETED

📁 Saved to:
   .claude/session_backups/emergency_20251111_175530

🎉 Safe to stop now!

Claude: Emergency save completed! Your work is safe. You can close everything now.
```

---

### Cách 2: Chạy Script Trực Tiếp

**Terminal:**
```bash
bash .claude/emergency_save.sh
```

**Output:**
```
🚨 EMERGENCY SAVE ACTIVATED
================================

📊 Capturing current state...
✅ Saved PROGRESS_NOTES.md
✅ Saved git status
✅ Saved git diff stats
✅ Saved changed files list (4 files)
✅ Saved full git diff
✅ Saved code snapshots
✅ Saved Flutter version

================================
✅ EMERGENCY SAVE COMPLETED

📁 Saved to:
   .claude/session_backups/emergency_20251111_175530

📄 Summary:
===========================================
EMERGENCY SAVE
===========================================
Timestamp: 2025-11-11 17:55:30
Location: .claude/session_backups/emergency_20251111_175530

Files changed: 4

Git status:
M mobile/lib/features/feed/presentation/widgets/post_card.dart
M mobile/lib/core/theme/app_theme.dart
A mobile/lib/core/animations/tap_animation.dart
M PROGRESS_NOTES.md

===========================================
Saved:
- PROGRESS_NOTES.md
- git_status.txt
- git_diff_stat.txt
- changed_files.txt
- git_diff_full.txt
- code_snapshot/
- flutter_version.txt

===========================================
Next Steps:
1. Review saved files in: .claude/session_backups/emergency_20251111_175530
2. Complete PROGRESS_NOTES.md if needed
3. Run proper session end when ready:
   bash .claude/session_end.sh

===========================================

Kill Flutter processes? [y/N]
```

**Nhấn `y` nếu muốn kill processes, `n` nếu không.**

---

### Sau Khi Emergency Save

**Khi bạn quay lại:**

**Xem những gì đã save:**
```bash
ls -lt .claude/session_backups/emergency_*
```

**Đọc summary:**
```bash
cat .claude/session_backups/emergency_20251111_175530/emergency_summary.txt
```

**Tiếp tục work (khi có thời gian):**
```bash
# Load context
bash .claude/smart_context_loader.sh

# Xem lại changes
cat .claude/session_backups/emergency_20251111_175530/PROGRESS_NOTES.md

# Tiếp tục code...
```

**Khi xong, chạy proper session end:**
```bash
bash .claude/session_end.sh
```

---

## 🔍 Search & Find Old Work {#search-find}

### Use Case 1: Tìm Work về Một Feature

**Scenario:** "Tôi nhớ tuần trước có làm gì đó với ProfilePage, nhưng không nhớ rõ"

**Search:**
```bash
bash .claude/search_sessions.sh "ProfilePage"
```

**Output:**
```
🔍 Searching sessions for: ProfilePage
================================

📁 session_20251107_010555
   Found in: progress_notes git_diff changed_files
   Snippet:
      ## ProfilePage Layout Update
      - Reorganized widget hierarchy
      - Added vote capacity section
   Location: .claude/session_backups/session_20251107_010555

📁 session_20251105_081425
   Found in: changed_files
   Location: .claude/session_backups/session_20251105_081425

================================
✨ Found in 2 session(s)
```

**Xem chi tiết:**
```bash
# Xem progress notes
cat .claude/session_backups/session_20251107_010555/PROGRESS_NOTES.md

# Xem file changes
cat .claude/session_backups/session_20251107_010555/git_diff_stat.txt

# Xem code cụ thể
cat .claude/session_backups/session_20251107_010555/code_snapshot/mobile/lib/features/profile/presentation/pages/profile_page.dart
```

---

### Use Case 2: Tìm Bug Fix

**Scenario:** "Tôi đã fix bug gì đó liên quan đến 'overlap', cần xem lại"

**Search:**
```bash
bash .claude/search_sessions.sh "overlap"
```

**Output:**
```
📁 session_20251107_010555
   Found in: progress_notes
   Snippet:
      ## Bug Fix: AppBar Title Overlap
      - Fixed title overlapping with TabBar
      - Updated padding constraints
```

---

### Use Case 3: Tìm File Cụ Thể

**Search by filename:**
```bash
bash .claude/search_sessions.sh "post_card.dart"
```

---

## 🗄️ Archive Management {#archive-management}

### Khi Nào Cần Archive?

- 📦 **Disk space thấp** (sessions chiếm nhiều dung lượng)
- 🗓️ **Hàng tháng** (routine cleanup)
- 🧹 **Muốn dọn dẹp** (giữ workspace gọn gàng)

### Archive Old Sessions

**Chạy archive:**
```bash
bash .claude/archive_manager.sh archive
```

**Output:**
```
🗄️  Archive Manager - Votzy
================================
Total sessions: 15
Keeping recent: 10

📦 Will archive 5 session(s)

Archiving: session_20251104_094730
  ✓ Archived
Archiving: session_20251104_175253
  ✓ Archived
Archiving: session_20251105_081425
  ✓ Archived
Archiving: session_20251107_001445
  ✓ Archived
Archiving: session_20251107_010555
  ✓ Archived

================================
✨ Archived 5 session(s)

Current sizes:
  • Active sessions: 2.1MB
  • Archived sessions: 650KB

💡 Tips:
  • Archived sessions are still searchable
  • Use 'bash .claude/restore_session.sh <name>' to restore
  • Digests and progress notes always preserved
```

**Lợi ích:**
- ✅ Disk space giảm ~70%
- ✅ Vẫn giữ được important files (PROGRESS_NOTES, summaries)
- ✅ Vẫn searchable
- ✅ Có thể restore bất cứ lúc nào

---

### List Archived Sessions

```bash
bash .claude/archive_manager.sh list
```

**Output:**
```
📁 Archived Sessions
================================

session_20251104_094730
  Size: 120K
  Files changed: 5

session_20251104_175253
  Size: 135K
  Files changed: 6

session_20251105_081425
  Size: 145K
  Files changed: 11

Total archive size: 650K
```

---

### Restore Archived Session

**Scenario:** "Tôi cần xem lại code từ session_20251104_094730"

```bash
bash .claude/archive_manager.sh restore session_20251104_094730
```

**Output:**
```
📦 Restoring: session_20251104_094730
================================

Copying preserved files...
Decompressing git diff...
Decompressing flutter doctor...
Decompressing code snapshot...

================================
✅ Session restored!

Location: .claude/session_backups/session_20251104_094730

Available files:
PROGRESS_NOTES.md
session_summary.txt
git_status.txt
git_diff_full.txt
...
```

---

## 🆘 Troubleshooting {#troubleshooting}

### Problem 1: "Permission denied" khi chạy script

**Error:**
```bash
bash: .claude/smart_context_loader.sh: Permission denied
```

**Solution:**
```bash
chmod +x .claude/*.sh
```

---

### Problem 2: Smart loader shows old data

**Issue:** Smart loader hiển thị session cũ, không phải current work

**Giải thích:** Smart loader hiển thị **LAST SESSION BACKUP**, không phải uncommitted changes.

**Xem current uncommitted work:**
```bash
git status
git diff --stat
git diff
```

---

### Problem 3: Không tìm thấy work cũ

**Issue:** Search không ra kết quả

**Solutions:**

1. **Try different keywords:**
```bash
# Thử filename
bash .claude/search_sessions.sh "post_card.dart"

# Thử feature name
bash .claude/search_sessions.sh "PostCard"

# Thử class name
bash .claude/search_sessions.sh "PostCardWidget"
```

2. **Browse manually:**
```bash
ls -lt .claude/session_backups/
cat .claude/session_backups/session_20251107_010555/PROGRESS_NOTES.md
```

3. **Check archived sessions:**
```bash
bash .claude/archive_manager.sh list
bash .claude/archive_manager.sh restore session_20251104_094730
```

---

### Problem 4: Disk space thấp

**Check sizes:**
```bash
du -sh .claude/session_backups
du -sh .claude/archived_sessions
```

**Solution 1: Archive old sessions**
```bash
bash .claude/archive_manager.sh archive
```

**Solution 2: Delete old emergency saves (if many)**
```bash
# Xem emergency saves
ls -lt .claude/session_backups/emergency_*

# Xóa cũ (carefully!)
rm -rf .claude/session_backups/emergency_20251101_*
```

---

### Problem 5: Flutter processes không kill được

**Check processes:**
```bash
ps aux | grep flutter
ps aux | grep dart
```

**Force kill:**
```bash
killall -9 dart flutter
```

**Verify:**
```bash
ps aux | grep flutter  # Should be empty
```

---

### Problem 6: Session end bị lỗi

**Error:** "git: command not found" hoặc similar

**Check git:**
```bash
git --version
which git
```

**Solution:** Install git nếu chưa có:
```bash
# macOS
xcode-select --install

# Homebrew
brew install git
```

---

## 💡 Tips & Tricks {#tips-tricks}

### Tip 1: Aliases cho Commands Thường Dùng

**Add vào ~/.zshrc hoặc ~/.bashrc:**
```bash
# Votzy Claude aliases
alias tt-start='cd /Users/macpro16/Documents/Intellij_Workspace/Votzy && bash .claude/smart_context_loader.sh'
alias tt-end='cd /Users/macpro16/Documents/Intellij_Workspace/Votzy && bash .claude/session_end.sh'
alias tt-save='cd /Users/macpro16/Documents/Intellij_Workspace/Votzy && bash .claude/emergency_save.sh'
alias tt-search='cd /Users/macpro16/Documents/Intellij_Workspace/Votzy && bash .claude/search_sessions.sh'
```

**Reload:**
```bash
source ~/.zshrc  # hoặc ~/.bashrc
```

**Usage:**
```bash
tt-start      # Bất cứ đâu, chạy smart context loader
tt-end        # End session
tt-save       # Emergency save
tt-search "keyword"  # Search
```

---

### Tip 2: Git Auto-Commit Before Session End

**Tạo alias:**
```bash
alias tt-commit-end='cd /Users/macpro16/Documents/Intellij_Workspace/Votzy && git add . && git commit -m "Session save: $(date)" && bash .claude/session_end.sh'
```

**Usage:**
```bash
tt-commit-end  # Auto commit + session end
```

---

### Tip 3: Quick Progress Notes Update

**Yêu cầu Claude:**
```
"Update PROGRESS_NOTES.md với format sau:
- Completed: [list features done]
- In Progress: [current work]
- Next: [planned work]"
```

Claude sẽ tự động update file cho bạn.

---

### Tip 4: Search Multiple Keywords

**AND search (cả hai keywords):**
```bash
bash .claude/search_sessions.sh "PostCard" | grep -i "animation"
```

**OR search (một trong hai):**
```bash
bash .claude/search_sessions.sh "PostCard"
bash .claude/search_sessions.sh "animation"
```

---

### Tip 5: Compare Sessions

**Xem changes giữa 2 sessions:**
```bash
# Get commit hashes from 2 sessions
cat .claude/session_backups/session_A/git_log.txt | head -1
cat .claude/session_backups/session_B/git_log.txt | head -1

# Compare
git diff <hash_A> <hash_B>
```

---

### Tip 6: Backup to Cloud

**Setup automatic backup to Google Drive/Dropbox:**
```bash
# Add to session_end.sh hoặc cronjob
rsync -av .claude/session_backups/ ~/Dropbox/Votzy_Sessions/
```

---

### Tip 7: View Session in Browser

**Convert session to HTML:**
```bash
# Install markdown viewer
npm install -g markdown-html

# Convert PROGRESS_NOTES
cat .claude/session_backups/session_20251107_010555/PROGRESS_NOTES.md | markdown-html > /tmp/session.html
open /tmp/session.html
```

---

## 📝 Real World Examples {#examples}

### Example 1: Typical Development Day

**8:00 AM - Bắt đầu**
```bash
# Open terminal
cd /Users/macpro16/Documents/Intellij_Workspace/Votzy
bash .claude/smart_context_loader.sh

# Đọc output
# "Ah, yesterday I was working on PostCard animation..."

# Start Claude
# "Let's continue with the PostCard tap animation"
```

**10:00 AM - Nhớ ra cần check something**
```bash
bash .claude/search_sessions.sh "VoteButton"
# Found in session_20251105_081425
cat .claude/session_backups/session_20251105_081425/PROGRESS_NOTES.md
# "Ah yes, that's how I did the haptic feedback"
```

**12:00 PM - Lunch, cần emergency save**
```
# In Claude conversation
You: SAVE NOW

Claude: Emergency save completed! Safe to go for lunch.
```

**2:00 PM - Quay lại**
```bash
bash .claude/smart_context_loader.sh
# Continue working...
```

**6:00 PM - Kết thúc ngày**
```
# Ask Claude
You: Update PROGRESS_NOTES.md với những gì đã làm hôm nay

Claude: [Updates PROGRESS_NOTES.md]

# End session
You: bash .claude/session_end.sh
```

---

### Example 2: Bug Fix Urgency

**Scenario:** Production bug, cần fix gấp

```bash
# 1. Start fresh
bash .claude/smart_context_loader.sh

# 2. Fix bug với Claude
"There's a crash in ProfilePage when..."

# 3. Test fix
flutter run

# 4. Bug fixed, commit
git add .
git commit -m "Fix: ProfilePage crash on tap"

# 5. Emergency save (phải deploy ngay)
bash .claude/emergency_save.sh

# 6. Deploy
# ...

# 7. Sau khi deploy xong, proper session end
bash .claude/session_end.sh
```

---

### Example 3: Feature Development Cycle

**Day 1 - Planning**
```bash
bash .claude/smart_context_loader.sh

# With Claude
"Let's plan the new Leaderboard feature..."

# End of day
"Update PROGRESS_NOTES.md:
## ✅ Completed
- Feature planning for Leaderboard
- Created wireframes
- Defined data models

## 🔄 Next Session
- [ ] Implement LeaderboardPage UI
- [ ] Connect to API
- [ ] Add sorting/filtering"

bash .claude/session_end.sh
```

**Day 2 - Implementation**
```bash
bash .claude/smart_context_loader.sh
# Reads: "Next: Implement LeaderboardPage UI"

# With Claude
"Let's implement the LeaderboardPage..."

# End of day
bash .claude/session_end.sh
```

**Day 3 - Testing & Polish**
```bash
bash .claude/smart_context_loader.sh

# With Claude
"Let's test the Leaderboard and polish it..."

# End of day
bash .claude/session_end.sh
```

**Review cycle:**
```bash
# Xem lại toàn bộ feature development
bash .claude/search_sessions.sh "Leaderboard"

# Found in 3 sessions - complete history!
```

---

### Example 4: Code Refactoring

**Before refactoring - Emergency save**
```bash
# Current state is working, save it
bash .claude/emergency_save.sh
```

**During refactoring**
```bash
# Make changes...
# If breaks, can reference emergency save

cat .claude/session_backups/emergency_20251111_150000/code_snapshot/...
```

**After refactoring**
```bash
# Proper session end
bash .claude/session_end.sh
```

---

### Example 5: Collaboration

**Scenario:** Teammate asks "How did you implement the vote animation?"

```bash
# Search for it
bash .claude/search_sessions.sh "vote animation"

# Found in session_20251105_081425

# Share the session
cat .claude/session_backups/session_20251105_081425/PROGRESS_NOTES.md

# Or share the code
cat .claude/session_backups/session_20251105_081425/code_snapshot/mobile/lib/features/voting/presentation/widgets/vote_button.dart
```

---

## 📊 Cheat Sheet

```bash
# ===== DAILY USE =====
bash .claude/smart_context_loader.sh      # Start session
bash .claude/session_end.sh               # End session
bash .claude/emergency_save.sh            # Quick save

# ===== IN CLAUDE CONVERSATION =====
"SAVE NOW"                                # Emergency save
"EMERGENCY SAVE"                          # Emergency save
"Update PROGRESS_NOTES.md"                # Update notes

# ===== SEARCH & FIND =====
bash .claude/search_sessions.sh "keyword"            # Search
ls -lt .claude/session_backups/                      # List sessions
cat .claude/session_backups/SESSION/PROGRESS_NOTES.md  # Read notes

# ===== ARCHIVE =====
bash .claude/archive_manager.sh archive   # Archive old
bash .claude/archive_manager.sh list      # List archived
bash .claude/archive_manager.sh restore SESSION  # Restore

# ===== MAINTENANCE =====
du -sh .claude/session_backups            # Check size
du -sh .claude/archived_sessions          # Check archive size
chmod +x .claude/*.sh                     # Fix permissions

# ===== GIT =====
git status                                # Current changes
git diff                                  # See changes
git log --oneline -20                     # Recent commits
```

---

## 📚 Next Steps

1. **Try emergency save:** Gõ "SAVE NOW" trong conversation này
2. **Set up aliases:** Add shortcuts vào shell
3. **Archive old sessions:** Clean up disk space
4. **Read README:** Full documentation trong README.md

---

## 🎯 Key Takeaways

✅ **3 Commands chính:**
- `smart_context_loader.sh` - Start session
- `session_end.sh` - End session
- `emergency_save.sh` - Emergency exit

✅ **Emergency Save:**
- Gõ "SAVE NOW" trong conversation
- < 5 giây, siêu nhanh

✅ **Token Savings:**
- 90% tiết kiệm với smart loader
- Always use smart loader, not full context

✅ **Search:**
- Find anything với `search_sessions.sh`
- All history preserved

✅ **Archive:**
- Monthly cleanup
- 70% space savings

---

**Happy Coding! 🚀**

**Version:** 2.0
**Last Updated:** 2025-11-11
**Project:** Votzy (Flutter)
