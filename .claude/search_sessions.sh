#!/bin/bash
# search_sessions.sh - Search through session history
# Usage: bash search_sessions.sh <keyword>

CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESSIONS_DIR="$CLAUDE_DIR/session_backups"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${RED}Usage:${NC} bash search_sessions.sh <keyword>"
    echo
    echo "Examples:"
    echo "  bash search_sessions.sh 'PostCard'"
    echo "  bash search_sessions.sh 'vote button'"
    echo "  bash search_sessions.sh 'profile page'"
    echo "  bash search_sessions.sh 'Flutter'"
    exit 1
fi

KEYWORD="$1"

echo -e "${BLUE}🔍 Searching sessions for: ${YELLOW}$KEYWORD${NC}"
echo "================================"
echo

FOUND_COUNT=0

# Search through all sessions
for SESSION_DIR in $(ls -t "$SESSIONS_DIR" | grep "^session_"); do
    SESSION_PATH="$SESSIONS_DIR/$SESSION_DIR"
    MATCHES=""

    # Search in PROGRESS_NOTES.md
    if [ -f "$SESSION_PATH/PROGRESS_NOTES.md" ]; then
        if grep -i -q "$KEYWORD" "$SESSION_PATH/PROGRESS_NOTES.md"; then
            MATCHES="${MATCHES}progress_notes "
        fi
    fi

    # Search in git diff
    if [ -f "$SESSION_PATH/git_diff_full.txt" ]; then
        if grep -i -q "$KEYWORD" "$SESSION_PATH/git_diff_full.txt"; then
            MATCHES="${MATCHES}git_diff "
        fi
    fi

    # Search in session summary
    if [ -f "$SESSION_PATH/session_summary.txt" ]; then
        if grep -i -q "$KEYWORD" "$SESSION_PATH/session_summary.txt"; then
            MATCHES="${MATCHES}summary "
        fi
    fi

    # Search in changed files list
    if [ -f "$SESSION_PATH/changed_files.txt" ]; then
        if grep -i -q "$KEYWORD" "$SESSION_PATH/changed_files.txt"; then
            MATCHES="${MATCHES}changed_files "
        fi
    fi

    # If found in any file
    if [ -n "$MATCHES" ]; then
        FOUND_COUNT=$((FOUND_COUNT + 1))
        echo -e "${GREEN}📁 $SESSION_DIR${NC}"
        echo -e "   Found in: ${YELLOW}$MATCHES${NC}"

        # Show snippet from PROGRESS_NOTES if available
        if echo "$MATCHES" | grep -q "progress_notes"; then
            echo -e "   ${BLUE}Snippet:${NC}"
            grep -i -B 1 -A 2 "$KEYWORD" "$SESSION_PATH/PROGRESS_NOTES.md" | head -5 | sed 's/^/      /'
        fi

        echo -e "   ${BLUE}Location:${NC} $SESSION_PATH"
        echo
    fi
done

if [ "$FOUND_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No sessions found containing '$KEYWORD'${NC}"
else
    echo "================================"
    echo -e "${GREEN}✨ Found in $FOUND_COUNT session(s)${NC}"
fi
