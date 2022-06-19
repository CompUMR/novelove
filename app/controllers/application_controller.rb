class ApplicationController < ActionController::Base

  # サインイン後の遷移先設定。
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      my_page_path(current_customer.id)
    end
  end

  # サインアウト後の遷移先設定。
  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :customer
      root_path
    end
  end

  protected

  # 管理者ログイン時、未ログイン時の遷移先設定。
  def authenticate_admin!
    if admin_signed_in?
      super
    else
      redirect_to new_admin_session_path, alert: "指定のページを表示するには、管理者ログインが必要です。"
    end
  end

  # 会員ログイン時、未ログイン時の遷移先設定。
  def authenticate_customer!
    if customer_signed_in?
      super
    else
      redirect_to new_customer_session_path, alert: "指定のページを表示するには、ログインが必要です。"
    end
  end
end
