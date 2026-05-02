#!/bin/bash
# rebrand.sh — perform repo-wide rebranding from xploitoverload/xploitoverload/sparkypanel to xploitoverload/sparkypanel
# Usage: run from repository root: sudo bash scripts/rebrand.sh [--apply]
set -euo pipefail

# Preview mode by default; pass --apply to modify files
APPLY=0
if [ "${1:-}" = "--apply" ]; then
  APPLY=1
fi

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="backups"
BACKUP_TAR="${BACKUP_DIR}/rebrand-backup-${TIMESTAMP}.tar.gz"

echo "Rebrand script — preview mode: $([ $APPLY -eq 0 ] && echo true || echo false)"

REPLACEMENTS=(
  "xploitoverload:xploitoverload"
  "xploitoverload:xploitoverload"
  "sparkypanel:sparkypanel"
  "raw.githubusercontent.com/xploitoverload:raw.githubusercontent.com/xploitoverload"
  "github.com/xploitoverload:github.com/xploitoverload"
  "raw.githubusercontent.com/xploitoverload:raw.githubusercontent.com/xploitoverload"
  "github.com/xploitoverload:github.com/xploitoverload"
)

# gather candidate files
FILES=$(grep -RIIl "xploitoverload\|xploitoverload\|sparkypanel\|raw.githubusercontent.com/xploitoverload\|github.com/xploitoverload\|raw.githubusercontent.com/xploitoverload\|github.com/xploitoverload" . || true)

if [ -z "$FILES" ]; then
  echo "No files found for targeted replacements."
  exit 0
fi

echo "Found files to consider (showing first 200 chars of list):"
printf "%s\n" "$FILES" | sed -n '1,200p'

if [ $APPLY -eq 1 ]; then
  echo "Creating backup: ${BACKUP_TAR}"
  mkdir -p "$BACKUP_DIR"
  # create a tarball of current repo state (exclude backups folder)
  tar --exclude="$BACKUP_DIR" -czf "$BACKUP_TAR" .
  echo "Backup created."

  echo "Applying replacements and saving per-file .bak copies..."
  while IFS= read -r file; do
    [ -f "$file" ] || continue
    cp -a "$file" "${file}.bak-${TIMESTAMP}" || true
    for pair in "${REPLACEMENTS[@]}"; do
      from=${pair%%:*}
      to=${pair#*:}
      # use perl for safer inplace with binary-safety disabled
      perl -0777 -pe "s/\Q${from}\E/${to}/g" -i "$file" || true
    done
    echo "Patched: $file (backup ${file}.bak-${TIMESTAMP})"
  done <<< "$FILES"

  echo "All replacements applied. Review changes with 'git status' and 'git diff'."
  echo "Backup tarball: ${BACKUP_TAR} and per-file .bak-* files were created."
else
  echo "Preview complete. To apply changes and create a backup run:"
  echo "  sudo bash scripts/rebrand.sh --apply"
fi
