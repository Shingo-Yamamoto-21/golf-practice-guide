#!/bin/zsh
set -euo pipefail

cd "/Users/shingoyamamoto/Library/Mobile Documents/com~apple~CloudDocs/Documents/Cursor/03_Project/golf-practice-guide"

echo "==> 認証確認"
gh auth status

echo "==> git 初期化"
if [ ! -d .git ]; then
  git init -b main
fi

git add -A
if git diff --cached --quiet; then
  echo "（コミット対象なし）"
else
  git commit -m "$(cat <<'EOF'
Add personal golf practice guide for iPad viewing via GitHub Pages.

EOF
)" || true
fi

# 既にコミットが無ければ作成を試みる
if ! git rev-parse HEAD >/dev/null 2>&1; then
  git commit --allow-empty -m "Initial commit"
fi

echo "==> GitHub リポジトリ作成 & push"
if git remote get-url origin >/dev/null 2>&1; then
  echo "remote origin は既にあります: $(git remote get-url origin)"
  git push -u origin HEAD
else
  gh repo create golf-practice-guide --public --source=. --remote=origin --push
fi

OWNER="$(gh api user -q .login)"
echo "==> Pages 有効化 (owner=$OWNER)"

# Pages が未設定なら作成、済みなら更新を試す
if ! gh api "repos/$OWNER/golf-practice-guide/pages" >/dev/null 2>&1; then
  gh api -X POST "repos/$OWNER/golf-practice-guide/pages" \
    -f build_type=legacy \
    -f 'source[branch]=main' \
    -f 'source[path]=/' || true
else
  gh api -X PUT "repos/$OWNER/golf-practice-guide/pages" \
    -f build_type=legacy \
    -f 'source[branch]=main' \
    -f 'source[path]=/' || true
fi

echo ""
echo "完了。iPadのSafariで開くURL:"
echo "https://${OWNER}.github.io/golf-practice-guide/"
echo ""
echo "反映まで1〜2分かかることがあります。"
