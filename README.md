# Todoリスト
## システム構成
### 使用した技術要素
-  Ruby on rails (Sinatra)
- sqlite3(heroku上ではpg)

### 全体の設計・構成について
- データベースのテーブルとしてはUserテーブル, ParentTask(やることリスト), ChildTask(やることリストの中身)の3つに分け、仕様に沿うような設計にした。
- 最新のChildTask(やることリストの中身)が更新されたらParentTaskの更新ランキングが変動してやることリストの表示順が変動するなどの工夫を行った。
- 仕様にない機能としてチームごとにタスクをわけられるアカウント機能と検索ボタンを押さなくても非同期で検索ができるリアルタイム検索機能を追加した。

### セットアップ手順
- 1st Step(プロジェクトのダウンロード)

`git clone https://github.com/patchgi/todo.git`
- 2nd Step(ライブラリのインストール)

`bundle install`
- 3rd Step(プログラムの起動)

`ruby app.rb`

 http://localhost:4567
 
 or 
 
 https://todo-clone.herokuapp.com
 
 にアクセス
