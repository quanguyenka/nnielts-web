#!/bin/bash
# smart_context_loader.sh - Intelligent context loading to save tokens
# Chỉ load context cần thiết thay vì load tất cả

CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$CLAUDE_DIR")"
SESSIONS_DIR="$CLAUDE_DIR/session_backups"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🧠 Smart Context Loader - Votzy${NC}"
echo "================================"

# 1. Get latest session
LATEST_SESSION=$(ls -t "$SESSIONS_DIR" | grep "^session_" | head -1)

if [ -z "$LATEST_SESSION" ]; then
    echo "⚠️  No previous sessions found"
    exit 0
fi

LATEST_PATH="$SESSIONS_DIR/$LATEST_SESSION"

echo -e "${GREEN}📂 Latest session:${NC} $LATEST_SESSION"
echo

# 2. Show compact session summary (instead of full content)
if [ -f "$LATEST_PATH/session_summary.txt" ]; then
    echo -e "${YELLOW}📊 Session Summary (compact):${NC}"
    # Only show key stats, not full content
    head -20 "$LATEST_PATH/session_summary.txt"
    echo
fi

# 3. Show PROGRESS_NOTES if exists (most important context)
if [ -f "$PROJECT_ROOT/PROGRESS_NOTES.md" ]; then
    echo -e "${YELLOW}📝 Progress Notes (last 30 lines):${NC}"
    tail -30 "$PROJECT_ROOT/PROGRESS_NOTES.md"
    echo
elif [ -f "$LATEST_PATH/PROGRESS_NOTES.md" ]; then
    echo -e "${YELLOW}📝 Progress Notes from last session (last 30 lines):${NC}"
    tail -30 "$LATEST_PATH/PROGRESS_NOTES.md"
    echo
fi

# 4. Show git status (current state only, not diff)
echo -e "${YELLOW}📊 Current Git Status:${NC}"
cd "$PROJECT_ROOT"
git status --short
echo

# 5. Smart diff summary (not full diff - saves tokens!)
CHANGED_FILES=$(git diff --name-only HEAD)
CHANGED_COUNT=$(echo "$CHANGED_FILES" | grep -c ".")

if [ "$CHANGED_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}🔄 Changed Files ($CHANGED_COUNT):${NC}"
    echo "$CHANGED_FILES" | head -10
    if [ "$CHANGED_COUNT" -gt 10 ]; then
        echo "   ... and $((CHANGED_COUNT - 10)) more files"
    fi
    echo

    echo -e "${YELLOW}📈 Change Statistics:${NC}"
    git diff --stat HEAD | tail -1
    echo
fi

# 6. Quick Flutter environment check (minimal)
echo -e "${YELLOW}🔍 Environment:${NC}"
if command -v flutter &> /dev/null; then
    echo "   Flutter: $(flutter --version 2>&1 | head -1 | cut -d' ' -f2)"
else
    echo "   Flutter: Not found"
fi
if command -v dart &> /dev/null; then
    echo "   Dart: $(dart --version 2>&1 | awk '{print $4}')"
else
    echo "   Dart: Not found"
fi
echo

# 7. Check Flutter processes
FLUTTER_PROCS=$(ps aux | grep -E "flutter|dart" | grep -v grep | wc -l)
if [ "$FLUTTER_PROCS" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Flutter processes running:${NC} $FLUTTER_PROCS"
else
    echo -e "${GREEN}✅ No Flutter processes running${NC}"
fi
echo

# 8. Offer to load full context if needed
echo -e "${BLUE}💡 Tips:${NC}"
echo "   • Full git diff: $LATEST_PATH/git_diff_full.txt"
echo "   • Code snapshots: $LATEST_PATH/code_snapshot/"
echo "   • Full context: bash .claude/session_start.sh"
echo "   • Search sessions: bash .claude/search_sessions.sh <keyword>"
echo

echo "================================"
echo -e "${GREEN}✨ Context loaded efficiently! (Token savings: ~80-90%)${NC}"
