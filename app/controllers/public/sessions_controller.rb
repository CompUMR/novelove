# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    customer = Customer.find_by(email: params[:customer][:email])
    # email、password、退会ステータスの確認。
    if customer && customer.valid_password?(params[:customer][:password]) && !customer.is_active
      redirect_to new_customer_registration_path, alert: "あなたは退会済みユーザーです。新規登録を行ってください(同じメールアドレスは使用できません)。"
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def withdraw_destroy
    destroy
    # フラッシュメッセージを上書き。
    flash[:notice] = "退会処理が完了しました。またのご利用をお待ちしています。"
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
