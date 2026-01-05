#!/bin/bash
# archive_manager.sh - Manage session archives
# Usage:
#   bash archive_manager.sh archive      # Archive old sessions
#   bash archive_manager.sh restore <name>  # Restore archived session
#   bash archive_manager.sh list         # List archived sessions

CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESSIONS_DIR="$CLAUDE_DIR/session_backups"
ARCHIVE_DIR="$CLAUDE_DIR/archived_sessions"

# Configuration
KEEP_RECENT=10  # Keep last 10 sessions in full

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Show usage
show_usage() {
    echo "Usage:"
    echo "  bash archive_manager.sh archive              # Archive old sessions"
    echo "  bash archive_manager.sh restore <session>    # Restore session"
    echo "  bash archive_manager.sh list                 # List archives"
    echo ""
    echo "Examples:"
    echo "  bash archive_manager.sh archive"
    echo "  bash archive_manager.sh restore session_20251107_010555"
    echo "  bash archive_manager.sh list"
}

# Archive old sessions
archive_sessions() {
    echo -e "${BLUE}🗄️  Archive Manager - Votzy${NC}"
    echo "================================"
    echo

    # Create archive directory if not exists
    mkdir -p "$ARCHIVE_DIR"

    # Get all sessions sorted by date (oldest first)
    ALL_SESSIONS=($(ls -t "$SESSIONS_DIR" | grep "^session_\|^emergency_" | tail -r))
    TOTAL_COUNT=${#ALL_SESSIONS[@]}

    echo "Total sessions: $TOTAL_COUNT"
    echo "Keeping recent: $KEEP_RECENT"
    echo

    if [ "$TOTAL_COUNT" -le "$KEEP_RECENT" ]; then
        echo -e "${GREEN}✅ No archiving needed (within keep limit)${NC}"
        return 0
    fi

    ARCHIVE_COUNT=$((TOTAL_COUNT - KEEP_RECENT))
    echo -e "${YELLOW}📦 Will archive $ARCHIVE_COUNT session(s)${NC}"
    echo

    # Archive old sessions
    ARCHIVED=0
    for SESSION in "${ALL_SESSIONS[@]:0:$ARCHIVE_COUNT}"; do
        SESSION_PATH="$SESSIONS_DIR/$SESSION"
        ARCHIVE_PATH="$ARCHIVE_DIR/$SESSION"

        echo -e "Archiving: ${YELLOW}$SESSION${NC}"

        # Create archive directory
        mkdir -p "$ARCHIVE_PATH"

        # Keep important files (small and useful)
        for FILE in PROGRESS_NOTES.md session_summary.txt emergency_summary.txt \
                    git_status.txt changed_files.txt git_log.txt \
                    QUICK_REFERENCE.md flutter_version.txt; do
            if [ -f "$SESSION_PATH/$FILE" ]; then
                cp "$SESSION_PATH/$FILE" "$ARCHIVE_PATH/"
            fi
        done

        # Compress large files
        if [ -f "$SESSION_PATH/git_diff_full.txt" ]; then
            gzip -c "$SESSION_PATH/git_diff_full.txt" > "$ARCHIVE_PATH/git_diff_full.txt.gz" 2>/dev/null
        fi

        if [ -f "$SESSION_PATH/flutter_doctor.txt" ]; then
            gzip -c "$SESSION_PATH/flutter_doctor.txt" > "$ARCHIVE_PATH/flutter_doctor.txt.gz" 2>/dev/null
        fi

        # Compress code snapshot if exists
        if [ -d "$SESSION_PATH/code_snapshot" ]; then
            tar -czf "$ARCHIVE_PATH/code_snapshot.tar.gz" -C "$SESSION_PATH" code_snapshot/ 2>/dev/null
        fi

        # Remove original session
        rm -rf "$SESSION_PATH"

        ARCHIVED=$((ARCHIVED + 1))
        echo -e "  ${GREEN}✓${NC} Archived"
    done

    echo
    echo "================================"
    echo -e "${GREEN}✨ Archived $ARCHIVED session(s)${NC}"

    # Show space savings
    SESSIONS_SIZE=$(du -sh "$SESSIONS_DIR" 2>/dev/null | awk '{print $1}')
    ARCHIVE_SIZE=$(du -sh "$ARCHIVE_DIR" 2>/dev/null | awk '{print $1}')

    echo
    echo "Current sizes:"
    echo "  • Active sessions: $SESSIONS_SIZE"
    echo "  • Archived sessions: $ARCHIVE_SIZE"
}

# Restore archived session
restore_session() {
    local SESSION_NAME="$1"

    if [ -z "$SESSION_NAME" ]; then
        echo -e "${RED}Error:${NC} Please specify session name"
        echo ""
        echo "Available archived sessions:"
        ls -1 "$ARCHIVE_DIR" 2>/dev/null | grep "^session_\|^emergency_"
        return 1
    fi

    ARCHIVE_PATH="$ARCHIVE_DIR/$SESSION_NAME"
    RESTORE_PATH="$SESSIONS_DIR/$SESSION_NAME"

    if [ ! -d "$ARCHIVE_PATH" ]; then
        echo -e "${RED}❌ Archived session not found:${NC} $SESSION_NAME"
        return 1
    fi

    echo -e "${BLUE}📦 Restoring: ${YELLOW}$SESSION_NAME${NC}"
    echo "================================"
    echo

    # Create restore directory
    mkdir -p "$RESTORE_PATH"

    # Copy preserved files
    echo "Copying preserved files..."
    cp -r "$ARCHIVE_PATH"/*.md "$RESTORE_PATH/" 2>/dev/null
    cp -r "$ARCHIVE_PATH"/*.txt "$RESTORE_PATH/" 2>/dev/null

    # Decompress git diff if exists
    if [ -f "$ARCHIVE_PATH/git_diff_full.txt.gz" ]; then
        echo "Decompressing git diff..."
        gunzip -c "$ARCHIVE_PATH/git_diff_full.txt.gz" > "$RESTORE_PATH/git_diff_full.txt"
    fi

    # Decompress flutter doctor if exists
    if [ -f "$ARCHIVE_PATH/flutter_doctor.txt.gz" ]; then
        echo "Decompressing flutter doctor..."
        gunzip -c "$ARCHIVE_PATH/flutter_doctor.txt.gz" > "$RESTORE_PATH/flutter_doctor.txt"
    fi

    # Decompress code snapshot if exists
    if [ -f "$ARCHIVE_PATH/code_snapshot.tar.gz" ]; then
        echo "Decompressing code snapshot..."
        tar -xzf "$ARCHIVE_PATH/code_snapshot.tar.gz" -C "$RESTORE_PATH/"
    fi

    echo
    echo "================================"
    echo -e "${GREEN}✅ Session restored!${NC}"
    echo
    echo "Location: $RESTORE_PATH"
}

# List archived sessions
list_archives() {
    echo -e "${BLUE}📁 Archived Sessions${NC}"
    echo "================================"
    echo

    if [ ! -d "$ARCHIVE_DIR" ] || [ -z "$(ls -A "$ARCHIVE_DIR" 2>/dev/null)" ]; then
        echo "No archived sessions found."
        return 0
    fi

    for SESSION in $(ls -t "$ARCHIVE_DIR" | grep "^session_\|^emergency_"); do
        SESSION_PATH="$ARCHIVE_DIR/$SESSION"
        SIZE=$(du -sh "$SESSION_PATH" 2>/dev/null | awk '{print $1}')

        echo -e "${GREEN}$SESSION${NC}"
        echo "  Size: $SIZE"

        if [ -f "$SESSION_PATH/session_summary.txt" ]; then
            FILES=$(grep "Files changed:" "$SESSION_PATH/session_summary.txt" | awk '{print $3}')
            echo "  Files changed: $FILES"
        fi

        echo ""
    done

    TOTAL_SIZE=$(du -sh "$ARCHIVE_DIR" 2>/dev/null | awk '{print $1}')
    echo "Total archive size: $TOTAL_SIZE"
}

# Main
case "$1" in
    archive)
        archive_sessions
        ;;
    restore)
        restore_session "$2"
        ;;
    list)
        list_archives
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
