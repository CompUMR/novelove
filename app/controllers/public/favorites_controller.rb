class Public::FavoritesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    favorite = Favorite.new(item_id: item.id)
    favorite.customer_id = current_customer.id
    # 「favorites情報」と「いいねされた小説のid情報」を持つ変数favoriteをデータベースに保存。
    favorite.save
    # itemsコントローラのshowアクションを実行後、いいねされた小説のshow.html.erb(小説詳細ページ)へ遷移。
    redirect_to item_path(item)
  end

  def destroy
    item = Item.find(params[:item_id])
    favorite = Favorite.find_by(item_id: item.id)
    favorite.customer_id = current_customer.id
    # データ（レコード）を削除
    favorite.destroy
    # itemsコントローラのshowアクションを実行後、コメントされた小説のshow.html.erb(小説詳細ページ)へ遷移。
    redirect_to item_path(item)
  end
end
