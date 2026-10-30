# ローカル検証

GitHub Actions はデプロイ（配布用成果物の生成を含む）に限定します。
テスト・lint・型チェック・検証ビルドはこのリポジトリのローカル pre-push フックで実行します。

各 clone で一度 `sh scripts/install-hooks.sh` を実行してください。コミット後、tracked 変更のない状態で `sh scripts/validate-local.sh` から同じ検査を手動実行できます。
検査失敗・HEAD と push 対象の不一致・検査前後の tracked 変更があると push を停止します。以前の成功記録を再利用せず、各 push で検査を実行します。

成功時は Git 管理領域の `local-validation/<完全なSHA>.md` に実行環境・時刻・コマンド・結果を記録します。PR 本文へその記録と、未実行・失敗・対象外の項目と理由を転記してください。

## 検査内容

- `git show --format= --check HEAD`

既存 package scripts と gulp/grunt の宣言された検査をローカルへ集約します。存在しない自動試験は追加しません。
既存の実自動テスト・lint・検証ビルド定義がなく、検査はコミット差分の空白エラーのみです。アプリ機能の試験済みを意味しません。
Node.js 18.12 以上、pnpm 10.33.4、Git、POSIX sh が必要です。依存は対応する package ディレクトリで `pnpm install --frozen-lockfile --ignore-scripts` を実行して準備します。公開待機10080分とインストールスクリプト既定無効を維持します。


## 移行時の設定検証

独立 package ごとに frozen lock を検査し、root JavaScript 設定は依存の実行なしで構文解析します。
- `pnpm install --lockfile-only --frozen-lockfile --ignore-scripts`

上記の設定/構文検査と、既存 app tests/lint/build の実行結果は分けて記録します。依存や SDK が未準備なら app 検査を成功扱いにしません。
