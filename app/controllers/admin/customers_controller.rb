class Admin::CustomersController < ApplicationController

  def comments
    @customer = Customer.find(params[:id])
    @comments = @customer.post_comments.order(created_at: "DESC").page(params[:page])
  end

  # 顧客一覧画面
  def index
    @customers = Customer.page(params[:page])
  end

  # 顧客詳細画面
  def show
    @customer = Customer.find(params[:id])
  end

  # 顧客編集画面
  def edit
    @customer = Customer.find(params[:id])
  end

  # 顧客情報の更新
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      # customersコントローラのshow.html.erbへ遷移。
      redirect_to admin_customer_path(@customer), notice: "会員情報を正常に保存しました。"
    else
      # 入力にエラーがあった場合は再度edit.html.erbを表示。
      render :edit
    end
  end

  protected
  def customer_params
    params.require(:customer).permit(:last_name, :last_name_kana, :email, :is_active)
  end
end
