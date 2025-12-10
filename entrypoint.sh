#!/usr/bin/env bash
set -euo pipefail

# Create /work if it doesn't exist and set permissive ownership for UID 1000
mkdir -p /work
chown -R 1000:1000 /work || true

# If arguments provided, run as UID 1000, else spawn interactive shell as UID 1000
if [ $# -gt 0 ]; then
  exec gosu 1000:1000 "$@"
else
  exec gosu 1000:1000 bash -l
fi
