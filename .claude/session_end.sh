#!/bin/bash

# Script tự động chạy khi kết thúc session
# Saves session backup + keeps root PROGRESS_NOTES.md as project overview
# Project: Votzy (Flutter)

echo "🔄 Saving session state..."

# Get timestamps
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
SESSION_DATE=$(date "+%Y%m%d_%H%M%S")
DATE_ONLY=$(date "+%Y-%m-%d")

# Create backup directory for this session
BACKUP_DIR=".claude/session_backups"
SESSION_DIR="$BACKUP_DIR/session_$SESSION_DATE"
mkdir -p "$SESSION_DIR"

echo "📁 Creating session folder: $SESSION_DIR"

# ================================
# 1. SAVE GIT STATUS
# ================================
echo "  📊 Saving git status..."
git status > "$SESSION_DIR/git_status.txt" 2>&1

# ================================
# 2. SAVE GIT DIFF
# ================================
git diff --stat > "$SESSION_DIR/git_diff_stat.txt" 2>&1
git diff > "$SESSION_DIR/git_diff_full.txt" 2>&1

# ================================
# 3. SAVE CHANGED FILES LIST
# ================================
git diff --name-only > "$SESSION_DIR/changed_files.txt" 2>&1
git diff --name-status > "$SESSION_DIR/changed_files_status.txt" 2>&1

# ================================
# 4. SAVE GIT LOG
# ================================
git log --oneline -20 > "$SESSION_DIR/git_log.txt" 2>&1

# ================================
# 5. SAVE PROJECT STRUCTURE
# ================================
tree -L 3 -I 'node_modules|build|.dart_tool|Pods' > "$SESSION_DIR/project_structure.txt" 2>&1 || \
find . -maxdepth 3 -type d ! -path "*/node_modules/*" ! -path "*/build/*" ! -path "*/.dart_tool/*" ! -path "*/Pods/*" > "$SESSION_DIR/project_structure.txt" 2>&1

# ================================
# 6. BACKUP CHANGED CODE FILES
# ================================
echo "  💾 Backing up changed code files..."
SNAPSHOT_DIR="$SESSION_DIR/code_snapshot"
mkdir -p "$SNAPSHOT_DIR"

git diff --name-only | while read -r file; do
    if [ -f "$file" ]; then
        FILE_DIR=$(dirname "$file")
        mkdir -p "$SNAPSHOT_DIR/$FILE_DIR"
        cp "$file" "$SNAPSHOT_DIR/$file"
    fi
done

echo "  ✅ Backed up $(find "$SNAPSHOT_DIR" -type f 2>/dev/null | wc -l | tr -d ' ') changed files"

# ================================
# 7. SAVE FLUTTER INFO
# ================================
if command -v flutter &> /dev/null; then
    echo "  📱 Saving Flutter info..."
    flutter --version > "$SESSION_DIR/flutter_version.txt" 2>&1
    flutter doctor > "$SESSION_DIR/flutter_doctor.txt" 2>&1
fi

# ================================
# 8. CREATE SESSION-SPECIFIC PROGRESS NOTES
# ================================
echo "  📝 Creating session-specific progress notes..."

# Extract git stats
FILES_CHANGED=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
FILES_STAGED=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
TOTAL_FILES=$((FILES_CHANGED + FILES_STAGED))
INSERTIONS=$(git diff --shortstat 2>/dev/null | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo 0)
DELETIONS=$(git diff --shortstat 2>/dev/null | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo 0)
BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

# Create session-specific PROGRESS_NOTES.md in backup folder
cat > "$SESSION_DIR/PROGRESS_NOTES.md" << EOF
# Session Progress Notes - $DATE_ONLY

**Session Time:** $TIMESTAMP
**Branch:** $BRANCH
**Files Changed:** $TOTAL_FILES files (+$INSERTIONS, -$DELETIONS)

---

## What Was Done This Session

### Changed Files by Category

**Modified Files ($FILES_CHANGED):**
\`\`\`
$(git diff --name-only 2>/dev/null | head -20)
\`\`\`

**Staged Files ($FILES_STAGED):**
\`\`\`
$(git diff --cached --name-only 2>/dev/null | head -20)
\`\`\`

### Git Status Snapshot
\`\`\`
$(git status --short 2>/dev/null | head -30)
\`\`\`

---

## Changes Summary

**Total Changes:**
- Files modified: $TOTAL_FILES
- Lines inserted: +$INSERTIONS
- Lines deleted: -$DELETIONS

**File Types Changed:**
- Dart files: $(git diff --name-only 2>/dev/null | grep '\.dart$' | wc -l | tr -d ' ')
- Config files: $(git diff --name-only 2>/dev/null | grep -E '\.(json|yaml|yml)$' | wc -l | tr -d ' ')
- Docs: $(git diff --name-only 2>/dev/null | grep '\.md$' | wc -l | tr -d ' ')

---

## Session Backup Contents

This folder contains:
- \`git_status.txt\` - Full git status
- \`git_diff_stat.txt\` - Diff statistics
- \`git_diff_full.txt\` - Complete diff
- \`changed_files.txt\` - List of changed files
- \`changed_files_status.txt\` - With A/M/D status
- \`git_log.txt\` - Recent commits
- \`project_structure.txt\` - Directory tree
- \`code_snapshot/\` - Backup of all changed files
- \`flutter_version.txt\` - Flutter version
- \`flutter_doctor.txt\` - Flutter doctor output

---

## To Resume Work

1. Review this session's changes:
   \`\`\`bash
   cat $SESSION_DIR/PROGRESS_NOTES.md
   \`\`\`

2. Check what was modified:
   \`\`\`bash
   cat $SESSION_DIR/git_diff_stat.txt
   \`\`\`

3. See full project overview:
   \`\`\`bash
   cat PROGRESS_NOTES.md
   \`\`\`

---

_Session ended: $TIMESTAMP_
_Backup location: $SESSION_DIR_
EOF

# ================================
# 9. COPY ROOT PROGRESS_NOTES.MD TO BACKUP
# ================================
if [ -f "PROGRESS_NOTES.md" ]; then
    echo "  📄 Copying root PROGRESS_NOTES.md to backup..."
    cp PROGRESS_NOTES.md "$SESSION_DIR/PROGRESS_NOTES_project_overview.md"
fi

# ================================
# 10. CREATE SESSION SUMMARY
# ================================
cat > "$SESSION_DIR/session_summary.txt" << EOF
===========================================
SESSION ENDED: $TIMESTAMP
===========================================

📁 Session Folder: $SESSION_DIR

📊 Statistics:
- Files changed: $TOTAL_FILES
- Files backed up: $(find "$SNAPSHOT_DIR" -type f 2>/dev/null | wc -l | tr -d ' ')
- Insertions: +$INSERTIONS
- Deletions: -$DELETIONS

📝 Changed Files:
$(git diff --name-status 2>&1 | head -20)

📊 Git Status:
$(git status --short 2>&1 | head -20)

🔧 Next Session Commands:
   cd /Users/macpro16/Documents/Intellij_Workspace/Votzy
   bash .claude/session_start.sh

📚 Files in This Backup:
   - PROGRESS_NOTES.md (session-specific)
   - PROGRESS_NOTES_project_overview.md (project-wide)
   - git_diff_full.txt (complete diff)
   - code_snapshot/ (changed files backup)

===========================================
EOF

# ================================
# 11. UPDATE SESSIONS INDEX
# ================================
cat > "$BACKUP_DIR/sessions_index.md" << 'INDEXHEADER'
# 📋 Session History Index

All sessions sorted by time (most recent first).

---

INDEXHEADER

# Add sessions to index (sorted by time, newest first)
for session_folder in $(ls -t "$BACKUP_DIR" | grep "^session_"); do
    if [ -d "$BACKUP_DIR/$session_folder" ]; then
        SESSION_NAME=$(basename "$session_folder")
        SESSION_TIME=$(cat "$BACKUP_DIR/$session_folder/session_summary.txt" 2>/dev/null | grep "SESSION ENDED:" | cut -d: -f2- || echo "Unknown")
        FILES_CHANGED=$(cat "$BACKUP_DIR/$session_folder/session_summary.txt" 2>/dev/null | grep "Files changed:" | grep -oE '[0-9]+' | head -1 || echo "0")

        cat >> "$BACKUP_DIR/sessions_index.md" << INDEXENTRY

## 📦 $SESSION_NAME

- **Time:** $SESSION_TIME
- **Files Changed:** $FILES_CHANGED
- **Summary:** [session_summary.txt]($SESSION_NAME/session_summary.txt)
- **Progress:** [PROGRESS_NOTES.md]($SESSION_NAME/PROGRESS_NOTES.md)
- **Code Snapshot:** [code_snapshot/]($SESSION_NAME/code_snapshot/)

---
INDEXENTRY
    fi
done

# ================================
# 12. CREATE QUICK REFERENCE CARD
# ================================
cat > "$SESSION_DIR/QUICK_REFERENCE.md" << EOF
# 🚀 Quick Reference - Session $SESSION_DATE

## 📌 Session Info
- **Project:** Votzy (Flutter)
- **Ended:** $TIMESTAMP
- **Files Changed:** $TOTAL_FILES
- **Changes:** +$INSERTIONS / -$DELETIONS

## 📂 What's in This Backup

\`\`\`
$SESSION_NAME/
├── PROGRESS_NOTES.md                   # This session's work
├── PROGRESS_NOTES_project_overview.md  # Project-wide overview
├── session_summary.txt                 # Quick summary
├── git_status.txt                      # Git status
├── git_diff_stat.txt                   # Diff stats
├── git_diff_full.txt                   # Full diff
├── changed_files.txt                   # Changed files list
├── changed_files_status.txt            # With A/M/D status
├── git_log.txt                         # Recent commits
├── project_structure.txt               # Directory tree
├── flutter_version.txt                 # Flutter version
├── flutter_doctor.txt                  # Flutter doctor
├── code_snapshot/                      # Backup of changed files
└── QUICK_REFERENCE.md                  # This file
\`\`\`

## 🔄 To Resume Next Session

\`\`\`bash
cd /Users/macpro16/Documents/Intellij_Workspace/Votzy
bash .claude/session_start.sh
\`\`\`

## 📚 Important Files

- **Project Overview:** ../../PROGRESS_NOTES.md
- **This Session's Work:** PROGRESS_NOTES.md
- **All Sessions:** ../sessions_index.md
- **Changed Code:** code_snapshot/

---

_Session: $SESSION_DATE_
_Status: Saved successfully_
EOF

echo ""
echo "✅ Session backup completed!"
echo "📁 Saved to: $SESSION_DIR"
echo ""
echo "📊 Session Statistics:"
echo "   - Files changed: $TOTAL_FILES"
echo "   - Files backed up: $(find "$SNAPSHOT_DIR" -type f 2>/dev/null | wc -l | tr -d ' ')"
echo "   - Changes: +$INSERTIONS / -$DELETIONS"
echo ""
echo "📚 Review this session: cat $SESSION_DIR/session_summary.txt"
echo "📚 Project overview: cat PROGRESS_NOTES.md"
echo "📚 All sessions index: cat $BACKUP_DIR/sessions_index.md"
echo ""
echo "👋 Session saved! 🌟"
