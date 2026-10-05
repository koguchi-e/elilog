# elilog

技術記事、学習記録、日記のための個人ブログです。

## ローカル起動

PostgreSQLを起動したうえで、以下を実行します。

Homebrewを使うmacOS環境では、PostgreSQL 14は次で起動できます。

```sh
brew services start postgresql@14
```

管理画面を使うために、起動前に管理用パスワードを設定します。管理画面は `http://localhost:3000/admin/login` です。

```sh
export ADMIN_PASSWORD='推測されにくい長いパスワード'
```

```sh
bin/setup
bin/rails db:prepare
bin/rails db:seed
bin/dev
```

`http://localhost:3000` を開くと記事一覧が表示されます。

## テスト

```sh
bundle exec rspec
```
