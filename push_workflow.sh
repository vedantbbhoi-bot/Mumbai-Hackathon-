#!/usr/bin/env bash
# Usage: ./push_workflow.sh <file> "<commit message>"
# Pushes ONE file to your backup repo first, then to a feature branch of the source repo.
# NEVER pushes to main of rohanol/decoy-hackathon-demo.
set -euo pipefail
FILE="$1"; MSG="$2"; BRANCH="feature/m2-vedant"
SRC="https://github.com/rohanol/decoy-hackathon-demo.git"
BACKUP="https://github.com/vedantbbhoi-bot/Mumbai-Hackathon-.git"
[ -d .git ] || { echo "Run inside your cloned repo"; exit 1; }
git remote get-url backup >/dev/null 2>&1 || git remote add backup "$BACKUP"
git checkout -B "$BRANCH"
echo "- $(TZ=Asia/Kolkata date '+%F %T') | $FILE | $MSG" >> PROGRESS_M2.md
git add "$FILE" PROGRESS_M2.md
git commit -m "$MSG"
git push backup "$BRANCH"            # 1) backup repo first
git push origin "$BRANCH"            # 2) then source repo, feature branch only
echo "Done. Open a Pull Request into main on GitHub; do not merge directly."
