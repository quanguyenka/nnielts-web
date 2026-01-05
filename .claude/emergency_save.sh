#!/bin/bash
# emergency_save.sh - Quick emergency save mechanism
# Usage: bash .claude/emergency_save.sh
# Hoặc: Trong conversation với Claude, gõ "SAVE NOW" hoặc "EMERGENCY SAVE"

CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$CLAUDE_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${RED}🚨 EMERGENCY SAVE ACTIVATED${NC}"
echo "================================"
echo

# 1. Quick git status
echo -e "${YELLOW}📊 Capturing current state...${NC}"
cd "$PROJECT_ROOT"

# 2. Create emergency backup folder
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
EMERGENCY_DIR="$CLAUDE_DIR/session_backups/emergency_$TIMESTAMP"
mkdir -p "$EMERGENCY_DIR"

# 3. Save PROGRESS_NOTES.md if exists
if [ -f "$PROJECT_ROOT/PROGRESS_NOTES.md" ]; then
    cp "$PROJECT_ROOT/PROGRESS_NOTES.md" "$EMERGENCY_DIR/"
    echo -e "${GREEN}✅${NC} Saved PROGRESS_NOTES.md"
else
    # Auto-generate quick notes
    cat > "$EMERGENCY_DIR/PROGRESS_NOTES.md" << EOF
# Emergency Save - $TIMESTAMP

## Status
Emergency save triggered at $(date "+%Y-%m-%d %H:%M:%S")

## Changed Files
$(git status --short 2>/dev/null || echo "Not in git repo")

## Recent Work
Check git diff for details.

## Next Steps
- Review changes
- Create proper progress notes
- Commit if ready

---
**Emergency save by:** emergency_save.sh
EOF
    echo -e "${YELLOW}⚠️${NC}  Auto-generated PROGRESS_NOTES.md"
fi

# 4. Save git status
git status > "$EMERGENCY_DIR/git_status.txt" 2>&1
echo -e "${GREEN}✅${NC} Saved git status"

# 5. Save git diff (compact)
git diff --stat > "$EMERGENCY_DIR/git_diff_stat.txt" 2>&1
echo -e "${GREEN}✅${NC} Saved git diff stats"

# 6. Save changed files list
git diff --name-only > "$EMERGENCY_DIR/changed_files.txt" 2>&1
CHANGED_COUNT=$(cat "$EMERGENCY_DIR/changed_files.txt" | wc -l | tr -d ' ')
echo -e "${GREEN}✅${NC} Saved changed files list ($CHANGED_COUNT files)"

# 7. Save full git diff (optional - might be large)
if [ "$CHANGED_COUNT" -lt 20 ]; then
    git diff > "$EMERGENCY_DIR/git_diff_full.txt" 2>&1
    echo -e "${GREEN}✅${NC} Saved full git diff"
else
    echo -e "${YELLOW}⚠️${NC}  Skipped full diff (too many files: $CHANGED_COUNT)"
fi

# 8. Quick snapshot of changed files
if [ "$CHANGED_COUNT" -gt 0 ] && [ "$CHANGED_COUNT" -lt 10 ]; then
    mkdir -p "$EMERGENCY_DIR/code_snapshot"
    while IFS= read -r file; do
        if [ -f "$PROJECT_ROOT/$file" ]; then
            FILE_DIR=$(dirname "$file")
            mkdir -p "$EMERGENCY_DIR/code_snapshot/$FILE_DIR"
            cp "$PROJECT_ROOT/$file" "$EMERGENCY_DIR/code_snapshot/$file" 2>/dev/null
        fi
    done < "$EMERGENCY_DIR/changed_files.txt"
    echo -e "${GREEN}✅${NC} Saved code snapshots"
fi

# 9. Save Flutter info
if command -v flutter &> /dev/null; then
    flutter --version > "$EMERGENCY_DIR/flutter_version.txt" 2>&1
    echo -e "${GREEN}✅${NC} Saved Flutter version"
fi

# 10. Create summary
cat > "$EMERGENCY_DIR/emergency_summary.txt" << EOF
===========================================
EMERGENCY SAVE
===========================================
Timestamp: $(date "+%Y-%m-%d %H:%M:%S")
Location: $EMERGENCY_DIR

Files changed: $CHANGED_COUNT

Git status:
$(git status --short 2>/dev/null || echo "Not in git repo")

===========================================
Saved:
- PROGRESS_NOTES.md
- git_status.txt
- git_diff_stat.txt
- changed_files.txt
$([ -f "$EMERGENCY_DIR/git_diff_full.txt" ] && echo "- git_diff_full.txt")
$([ -d "$EMERGENCY_DIR/code_snapshot" ] && echo "- code_snapshot/")
- flutter_version.txt

===========================================
Next Steps:
1. Review saved files in: $EMERGENCY_DIR
2. Complete PROGRESS_NOTES.md if needed
3. Run proper session end when ready:
   bash .claude/session_end.sh

===========================================
EOF

echo
echo "================================"
echo -e "${GREEN}✅ EMERGENCY SAVE COMPLETED${NC}"
echo
echo -e "${BLUE}📁 Saved to:${NC}"
echo "   $EMERGENCY_DIR"
echo
echo -e "${BLUE}📄 Summary:${NC}"
cat "$EMERGENCY_DIR/emergency_summary.txt"
echo

# 11. Kill Flutter processes if requested
echo -e "${YELLOW}Kill Flutter processes? [y/N]${NC}"
read -t 5 -n 1 KILL_PROCESSES
echo
if [[ "$KILL_PROCESSES" =~ ^[Yy]$ ]]; then
    killall -9 dart flutter 2>/dev/null
    echo -e "${GREEN}✅${NC} Killed Flutter processes"
else
    echo -e "${BLUE}ℹ️${NC}  Keeping Flutter processes running"
fi

echo
echo -e "${GREEN}🎉 Safe to stop now!${NC}"
echo
