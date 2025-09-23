#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Memory: Optimize
# @raycast.mode compact
# @raycast.packageName Memory Tools
# @raycast.icon 🧠

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/memory-shortcut.sh" optimize


