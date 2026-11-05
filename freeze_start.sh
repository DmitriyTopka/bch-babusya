#!/bin/bash
# Run ONCE on 14.11 (after 14:00 UTC kick-off, before any new work).
# Copies the current page and assets into start/ as the frozen "as of 14 Nov" snapshot,
# then commits and tags it. Push only after Dima's "da".
set -euo pipefail
cd "$(dirname "$0")"
[ -d start ] && { echo "start/ already exists, refusing to overwrite"; exit 1; }
mkdir -p start
cp -R index.html assets start/
# inside the snapshot the "starting point" link points to itself
sed -i "" -e "s#href=\"./start/\"#href=\"./\"#" -e "s#href=\"\#final\"#href=\"../\#final\"#" start/index.html
git add start && git commit -m "Freeze starting point as of 14 Nov 2026" && git tag start-2026-11-14
echo "Frozen. Check start/index.html, then push with: git push && git push --tags"
