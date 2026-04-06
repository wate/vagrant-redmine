#!/usr/bin/env bash

# help配下のMarkdownリンクをRedmine wiki記法へ正規化する

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_DIR="${1:-${REPO_DIR}/provision/files/wiki/help}"

readonly -a LINK_RULES=(
  # 固定ページ
  $'チケット管理の仕組み	[[チケット管理の仕組み]]'
  $'チケット管理の流れ	[[チケット管理の流れ]]'
  $'成果物ごとの役割	[[成果物ごとの役割]]'

  # FAQ系: 部分一致しやすい短い名前は後ろに置く
  $'判断に迷ったときのFAQと実例	[[判断に迷ったときのFAQと実例]]'
  $'FAQと実例	[[判断に迷ったときのFAQと実例|FAQと実例]]'

  # ワークフロー・種別
  $'ワークフロー	[[ワークフロー]]'
  $'タスク	[[タスク]]'
  $'要望	[[要望]]'
  $'不具合	[[不具合]]'
  $'問い合わせ	[[問い合わせ]]'
  $'運用保守	[[運用保守]]'
  $'その他	[[その他]]'
)

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "対象ディレクトリが存在しません: $TARGET_DIR" >&2
  exit 1
fi

build_perl_script() {
  local rule label replacement

  for rule in "${LINK_RULES[@]}"; do
    IFS=$'\t' read -r label replacement <<< "$rule"
    printf 's{\\[\\Q%s\\E\\]\\([^)]+\\)}{%s}g;\n' "$label" "$replacement"
  done
}

normalize_links() {
  local perl_script

  perl_script="$(build_perl_script)"
  find . -type f -name '*.md' -exec perl -0pi -e "$perl_script" {} +
}

cd "$TARGET_DIR"
normalize_links

echo "Redmine wikiリンクを正規化しました: $TARGET_DIR"
