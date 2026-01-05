#!/bin/bash

# Script to start Claude Code with session information
# Usage:
#   - From project root: ./.claude/start_with_claude.sh
#   - From .claude dir:  ./start_with_claude.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Change to project root to ensure paths work correctly
cd "$PROJECT_ROOT" || exit 1

# Run the session start script to show information
bash .claude/session_start.sh

echo ""
echo "🚀 Khởi động Claude Code..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Start Claude Code
claude
