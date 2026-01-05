#!/bin/bash

# Script tự động chạy khi bắt đầu session
# Usage: bash .claude/session_start.sh
# Project: Votzy (Flutter)

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$SCRIPT_DIR"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}👋 Starting new session - Votzy...${NC}"
echo ""

# ================================
# 1. NEXT UP - WHAT TO DO NOW
# ================================
if [ -f "$CLAUDE_DIR/NEXT_UP.md" ]; then
    echo -e "${GREEN}🚀 NEXT UP - QUICK ACTION GUIDE${NC}"
    echo "================================"
    # Show first 50 lines (TL;DR + Task #1)
    head -50 "$CLAUDE_DIR/NEXT_UP.md"
    echo ""
    echo -e "${YELLOW}   📄 Full guide: .claude/NEXT_UP.md${NC}"
    echo "================================"
    echo ""
fi

# ================================
# 2. CURRENT TASKS
# ================================
if [ -f "$CLAUDE_DIR/CURRENT_TASKS.md" ]; then
    echo -e "${CYAN}🎯 CURRENT TASKS${NC}"
    echo "================================"
    # Show first 40 lines
    head -40 "$CLAUDE_DIR/CURRENT_TASKS.md"
    echo ""
    echo -e "${YELLOW}   📄 Full tasks: .claude/CURRENT_TASKS.md${NC}"
    echo "================================"
    echo ""
fi

# ================================
# 3. COMPLETION TRACKER (Summary)
# ================================
if [ -f "$CLAUDE_DIR/COMPLETION_TRACKER.md" ]; then
    echo -e "${GREEN}✅ COMPLETION TRACKER${NC}"
    echo "================================"
    # Show only progress overview (first 20 lines)
    head -20 "$CLAUDE_DIR/COMPLETION_TRACKER.md"
    echo ""
    echo -e "${YELLOW}   📄 Full tracker: .claude/COMPLETION_TRACKER.md${NC}"
    echo "================================"
    echo ""
fi

# ================================
# 4. LAST SESSION SUMMARY
# ================================
BACKUP_DIR="$CLAUDE_DIR/session_backups"
if [ -d "$BACKUP_DIR" ]; then
    LATEST_SESSION=$(ls -t "$BACKUP_DIR" | grep "^session_" | head -1)
    if [ -n "$LATEST_SESSION" ]; then
        LATEST_SUMMARY="$BACKUP_DIR/$LATEST_SESSION/session_summary.txt"
        if [ -f "$LATEST_SUMMARY" ]; then
            echo -e "${CYAN}📋 LAST SESSION SUMMARY:${NC}"
            echo "================================"
            cat "$LATEST_SUMMARY"
            echo "================================"
            echo ""
        fi
    fi
fi

# Skip PROGRESS.md and SESSION_PROGRESS for now (too verbose)
# Can access via .claude/ directory if needed

# ================================
# 5. USER PREFERENCES
# ================================
if [ -f "$CLAUDE_DIR/user_preferences.md" ]; then
    echo -e "${CYAN}⚙️  USER PREFERENCES (Key Points):${NC}"
    echo "================================"
    # Show important sections
    echo -e "${YELLOW}🔧 Development Workflow:${NC}"
    sed -n '/## 🔧 Development Workflow/,/## /p' "$CLAUDE_DIR/user_preferences.md" | head -20
    echo ""
    echo -e "${YELLOW}📱 Device & Environment:${NC}"
    sed -n '/## 📱 Device & Environment/,/## /p' "$CLAUDE_DIR/user_preferences.md" | head -10
    echo ""
    echo -e "${YELLOW}💬 Communication Style:${NC}"
    sed -n '/## 💬 Communication Style/,/## /p' "$CLAUDE_DIR/user_preferences.md" | head -8
    echo ""
    echo -e "${YELLOW}   📄 Full preferences: .claude/user_preferences.md${NC}"
    echo "================================"
    echo ""
fi

# ================================
# 5. DOCUMENTATION INDEX
# ================================
if [ -f "$CLAUDE_DIR/INDEX.md" ]; then
    echo -e "${CYAN}📚 AVAILABLE DOCUMENTATION:${NC}"
    echo "================================"
    echo -e "${YELLOW}Quick Access:${NC}"
    echo "   • .claude/INDEX.md - Documentation index"
    echo "   • .claude/QUICK_START.md - Quick start guide"
    echo "   • .claude/USER_GUIDE.md - Complete user guide"
    echo "   • .claude/README.md - Full documentation"
    echo "   • .claude/WORKFLOW.md - Workflow guidelines"
    echo ""
    echo -e "${YELLOW}Key Scripts:${NC}"
    echo "   • bash .claude/smart_context_loader.sh - Smart context loading"
    echo "   • bash .claude/search_sessions.sh <keyword> - Search previous sessions"
    echo "   • bash .claude/archive_manager.sh - Manage session archives"
    echo "   • bash .claude/emergency_save.sh - Emergency save current work"
    echo "================================"
    echo ""
fi

# ================================
# 6. PROJECT PROGRESS OVERVIEW
# ================================
if [ -f "$PROJECT_ROOT/PROGRESS_NOTES.md" ]; then
    echo -e "${GREEN}📖 PROJECT PROGRESS OVERVIEW${NC}"
    echo "================================"
    # Show first 100 lines (Current State + Features Status)
    head -100 "$PROJECT_ROOT/PROGRESS_NOTES.md"
    echo ""
    echo -e "${YELLOW}   📄 Full overview: PROGRESS_NOTES.md${NC}"
    echo "================================"
    echo ""
else
    echo -e "${YELLOW}⚠️  PROGRESS_NOTES.md not found${NC}"
    echo "   Run '/save-progress' to create project overview"
    echo ""
fi

# ================================
# 7. DESIGN PHILOSOPHY & ROADMAP (From README)
# ================================
if [ -f "$PROJECT_ROOT/README.md" ]; then
    echo -e "${CYAN}🎨 DESIGN PHILOSOPHY & ROADMAP (README Requirements):${NC}"
    echo "================================"

    # Extract Roadmap (lines 202-227)
    echo -e "${YELLOW}📍 Development Roadmap (Current Phases):${NC}"
    sed -n '202,227p' "$PROJECT_ROOT/README.md"
    echo ""

    # Extract Design Philosophy (lines 230-248)
    echo -e "${YELLOW}🎨 Design Principles to Follow:${NC}"
    sed -n '230,248p' "$PROJECT_ROOT/README.md"
    echo ""

    # Extract Psychology Principles (lines 252-260)
    echo -e "${YELLOW}🧠 Psychology Principles Applied:${NC}"
    sed -n '252,260p' "$PROJECT_ROOT/README.md"

    echo "================================"
    echo ""
fi

# ================================
# 8. FLUTTER ENVIRONMENT
# ================================
echo -e "${CYAN}📱 Flutter Environment:${NC}"
if command -v flutter &> /dev/null; then
    flutter --version 2>&1 | head -1
else
    echo "   ⚠️  Flutter not found in PATH"
fi
echo ""

# ================================
# 9. DART ENVIRONMENT
# ================================
echo -e "${CYAN}🎯 Dart Environment:${NC}"
if command -v dart &> /dev/null; then
    dart --version 2>&1
else
    echo "   ⚠️  Dart not found in PATH"
fi
echo ""

# ================================
# 10. GIT STATUS
# ================================
echo -e "${CYAN}📊 Current git status:${NC}"
cd "$PROJECT_ROOT"
git status --short 2>/dev/null || echo "Not in a git repository"
echo ""

# ================================
# 11. RUNNING FLUTTER PROCESSES
# ================================
echo -e "${CYAN}🔍 Checking for running Flutter processes...${NC}"
FLUTTER_PROCS=$(ps aux | grep -E "flutter|dart" | grep -v grep | wc -l)
if [ "$FLUTTER_PROCS" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Found $FLUTTER_PROCS Flutter/Dart processes running${NC}"
    echo "   Process details:"
    ps aux | grep -E "flutter|dart" | grep -v grep | head -5
    echo ""
    echo "   To stop: killall -9 dart flutter"
else
    echo -e "${GREEN}✅ No Flutter processes running - clean state${NC}"
fi
echo ""

# ================================
# 12. IOS SIMULATOR CHECK
# ================================
echo -e "${CYAN}🔍 Checking iOS Simulator...${NC}"
IOS_SIM=$(xcrun simctl list devices | grep "Booted" | wc -l)
if [ "$IOS_SIM" -gt 0 ]; then
    echo "   ℹ️  iOS Simulator is running"
    xcrun simctl list devices | grep "Booted"
else
    echo "   ✅ No iOS Simulator running"
fi
echo ""

# ================================
# 13. QUICK START COMMANDS
# ================================
echo -e "${CYAN}⚡ QUICK START COMMANDS:${NC}"
echo "   flutter pub get              # Install dependencies"
echo "   flutter run                  # Run on default device"
echo "   flutter devices              # List available devices"
echo "   flutter clean                # Clean build cache"
echo "   flutter doctor               # Check Flutter setup"
echo ""

echo -e "${GREEN}✨ Ready to code! Happy hacking! ✨${NC}"
