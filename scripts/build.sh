#!/usr/bin/env bash
# 把 notes/ 下的每个 .md 笔记生成为 pdf/ 下同名 PDF
# 依赖: pandoc, node + playwright
set -euo pipefail
cd "$(dirname "$0")/.."
NODE_PATH="${NODE_PATH:-$(npm root -g)}"
export NODE_PATH
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

for md in notes/*/*.md; do
  name=$(basename "$md" .md)
  pandoc "$md" -f markdown -t html5 -s --embed-resources --css style/note.css \
    -o "$tmp/$name.html"
  node scripts/pdf.js "$tmp/$name.html" "pdf/$name.pdf"
  echo "生成: pdf/$name.pdf"
done
