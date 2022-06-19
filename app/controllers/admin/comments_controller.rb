class Admin::CommentsController < ApplicationController
  # コメント詳細画面
  def show
    @comment = PostComment.find(params[:id])
  end

  def destroy
    comment = PostComment.find(params[:id])  # データ（レコード）を1件取得。
    comment.destroy  # データ（レコード）を削除
    # itemsコントローラのshowアクションを実行後、コメントされた小説のshow.html.erb(小説詳細ページ)へ遷移。
    redirect_to admin_root_path, notice: "コメント情報を削除しました。"
  end
end
