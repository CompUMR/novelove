class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  # ユーザーがいいねした小説一覧ページの表示
  def liked
    searched = current_customer.favorites.map(&:item_id)
    @title = current_customer.last_name + "さんがいいねした小説一覧"
    set_items(searched)
    render :posted
  end

  # ユーザーが投稿した小説一覧ページの表示
  def posted
    target = Customer.find(current_customer.id)
    searched = Item.where(customer: target)
    @title = target.last_name + "さんの小説一覧"
    set_items(searched)
    render :posted
  end

  # 顧客のマイページ
  def show
  end

  # 顧客の登録情報編集画面
  def edit
  end

  # 顧客の登録情報更新
  def update
    if current_customer.update(customer_params)
      redirect_to my_page_path(current_customer.id), notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  # 顧客の退会確認
  def unsubscribe
  end

  # 顧客の退会処理(ステータスの更新)
  def withdraw
    current_customer.update(is_active: false)
    reset_session
    # トップ画面へリダイレクト。
    redirect_to root_path
  end

  private
  # 引数で渡されたitems(小説)の数を@items_countに格納、10件ずつの小説情報を@itemsに格納。
  def set_items(source)
    @items_count = source.size
    @items = Item.where(id: source).page(params[:page]).per(10)
  end

  def customer_params
    params.require(:customer).permit(:last_name, :last_name_kana, :email)
  end
end
