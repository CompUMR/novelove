class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      ## 会員IDを保存するカラム
      t.integer :customer_id, foreign_key: true
      ## いいねIDを保存するカラム
      t.integer :favorite_id, foreign_key: true
      ## ジャンルIDを保存するカラム
      t.integer :genre_id, null: false, foreign_key: true
      ## 小説名を保存するカラム
      t.string :name, null: false
      ## 小説説明文を保存するカラム
      t.text :introduction, null: false
      ## 公開ステータスを保存するカラム
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
