#!/usr/bin/env bash
# Package each skill as a zip for upload to the Claude app (Settings → Capabilities → Skills).
# The Claude app only accepts the Agent Skills frontmatter keys, so Claude Code-only
# keys like `argument-hint` are stripped from the packaged copy.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
skills="$root/plugins/patient-advocate/skills"
dist="$root/dist"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

rm -rf "$dist"
mkdir -p "$dist"

for dir in "$skills"/*/; do
  name="$(basename "$dir")"
  cp -R "$dir" "$work/$name"
  sed -i.bak '/^argument-hint:/d' "$work/$name/SKILL.md" && rm "$work/$name/SKILL.md.bak"
  (cd "$work" && zip -qr "$dist/$name.zip" "$name" -x '*.DS_Store')
  echo "Built dist/$name.zip"
done
