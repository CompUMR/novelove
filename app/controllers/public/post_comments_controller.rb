class Public::PostCommentsController < ApplicationController
  def create
    # コメントされた小説の情報を格納。
    item = Item.find(params[:item_id])
    comment = PostComment.new(post_comment_params)
    comment.customer_id = current_customer.id
    comment.item_id = item.id
    comment.save
    # itemsコントローラのshowアクションを実行後、コメントされた小説のshow.html.erb(小説詳細ページ)へ遷移。
    redirect_to item_path(item)
  end

  def destroy
    comment = PostComment.find(params[:id])  # データ（レコード）を1件取得。
    comment.destroy  # データ（レコード）を削除
    # itemsコントローラのshowアクションを実行後、コメントされた小説のshow.html.erb(小説詳細ページ)へ遷移。
    redirect_to item_path(params[:item_id]), notice: "コメント情報を削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
