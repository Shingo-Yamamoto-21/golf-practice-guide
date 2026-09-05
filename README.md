# golf-practice-guide

朽木地域ゴルフ大会（2026-09-20）向けの個人用練習ガイド。
GitHub Pages で iPad の Safari から開く想定。

## 公開URL（Pages設定後）

`https://<GitHubユーザー名>.github.io/golf-practice-guide/`

- 練習メニュー: `.../golf-practice-guide/`
- 基本とミス対策: `.../golf-practice-guide/swing-basics.html`

## 検索エンジン対策

- 各HTMLに `<meta name="robots" content="noindex, nofollow">` を付与済み
- `robots.txt` でクロール抑制（補助）

※ 公開リポジトリの Pages は誰でもURLを知れば見られます。検索に載せない設定であり、パスワード保護ではありません。

## Cursor からの更新手順

```bash
cd "03_Project/golf-practice-guide"
# Obsidian側を直した場合は先に同期
# rsync -a --delete "../path-to-obsidian-folder/" ./

git add -A
git commit -m "Update practice guide"
git push
```

Pages は `main` ブランチのルート公開なら、push後1〜2分で反映されます。
