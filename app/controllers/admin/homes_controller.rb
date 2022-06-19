class Admin::HomesController < ApplicationController
  # 管理者トップページ(注文履歴一覧)
  def top
    @comments = PostComment.order(created_at: "DESC").page(params[:page]).per(10)
  end
end
