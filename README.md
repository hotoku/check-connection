# check-connection

## 概要

特定のipへpingを送り、成功/失敗をslack incoming webhookに通知する。

ここに置いてあるスクリプトは、一回、上記の動作を行うのみ。定期的に実行するには、cronで`main.bash`を実行する。

## cronの設定

1. `crontab -e`でエディタが起動する
1. `0 * * * * <レポジトリのパス>/main.bash`を追記する（1時間ごとにチェックするようになる）

## incoming webhookの設定

incoming webhook用のURLが必要。[ドキュメント](https://api.slack.com/messaging/webhooks#getting-started)を読んで用意する。

`credentials/urls.json`に、以下の内容で登録しておく。

```json
{
    "url": "取得したURL"
}
```

