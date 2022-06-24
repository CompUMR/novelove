# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストデータの用意。(rails db:seedコマンドを実行、登録)
# 本番環境でrails db:seedやrails db:migrateコマンドを実行する際は、必ず後ろにRAILS_ENV=productionという本番環境である事を示すコードをつける事。
# !をつけると、rails db:seedコマンド(開発環境)若しくは、bundle exec rails db:seed RAILS_ENV=productionコマンド(本番環境)を実行した際、
# 正常にデータが作成されなければエラーとなり、エラー画面が表示される為、正しく作成されなかった事が一目で分かるようになる。
# !をつけないとadminインスタンスか、falseが返ってくるだけになり、エラー画面が表示される訳ではなくなる為、ちゃんと作成されたのかが分からなくなる。
# saveやupdateメソッドについても同様。「ユーザーが使う部分の機能に関しては、!はつけない、管理者や開発者が使う部分の機能に関しては!をつける」
# という認識でいればOK。
Admin.create!(
  email: 'test1@example.com',
  password: 'test1test1'
)