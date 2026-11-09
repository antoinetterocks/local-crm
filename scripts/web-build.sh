#!/usr/bin/env bash
# Build the CRM web app from the artology submodule with artology's own
# toolchain, then put it where Capacitor (webDir) and Tauri (frontendDist)
# look for it: ./dist. local-crm never copies or patches artology's code.
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -f artology/package.json ]; then
  echo "artology submodule missing — run: git submodule update --init" >&2
  exit 1
fi

# Install artology's dependencies only when its lockfile changed.
stamp=artology/node_modules/.local-crm-lock
if [ ! -f "$stamp" ] || ! cmp -s artology/package-lock.json "$stamp"; then
  (cd artology && npm ci --no-audit --no-fund)
  cp artology/package-lock.json "$stamp"
fi

(cd artology && npm run build:crm${CRM_BRAND:+:$CRM_BRAND})
rm -rf dist
cp -R artology/dist-crm dist
echo "CRM web build → dist/"
