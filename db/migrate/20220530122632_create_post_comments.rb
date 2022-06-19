class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      # コメントを保存するカラム
      t.text :comment, null: false
      ## 会員IDを保存するカラム
      t.integer :customer_id, null: false, foreign_key: true
      ## 小説IDを保存するカラム
      t.integer :item_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
