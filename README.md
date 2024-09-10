# check-connection

## 概要

特定の ip へ ping を送り、成功/失敗を slack incoming webhook に通知する。

ここに置いてあるスクリプトは、一回、上記の動作を行うのみ。定期的に実行するには、cron で`main.bash`を実行する。

## cron の設定

1. `crontab -e`でエディタが起動する
1. `*/10 * * * * <レポジトリのパス>/main.bash`を追記する（10 分ごとにチェックするようになる）

## incoming webhook の設定

incoming webhook 用の URL が必要。[ドキュメント](https://api.slack.com/messaging/webhooks#getting-started)を読んで用意する。

`credentials/urls.json`に、以下の内容で登録しておく。

```json
{
  "url": "取得したURL"
}
```

## ネットワーク I/F の再起動

接続エラーが起こった場合、クライアント側で

```shell
sudo wg-quick down wg0
sudo wg-quick up wg0
```

を実行する。
