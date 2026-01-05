---
description: Save session and update project overview (token-optimized)
---

Execute the session end script to save session backup and update project overview:

```bash
cd /Users/macpro16/Documents/Intellij_Workspace/Votzy && bash .claude/session_end.sh
```

**What this does:**
- Creates session backup in `.claude/session_backups/`
- Updates root `PROGRESS_NOTES.md` with project overview
- Saves git status, changed files, and code snapshots

**Do NOT:**
- Read or analyze code
- Write progress notes manually
- Ask questions about content

**Just:**
- Run the bash script
- Report success/failure
- Show session folder path

Token usage: ~500 tokens (script handles everything)