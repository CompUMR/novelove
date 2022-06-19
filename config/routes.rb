Rails.application.routes.draw do

  scope module: :public do
    get '/customers/edit' => 'customers#edit'
    patch '/customers' => 'customers#update'
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    # 退会後、リダイレクト用にgetメソッドによるログアウトを追加
    get '/customer/sign_out', to: 'public/sessions#withdraw_destroy', as: :customer_log_out
  end

  namespace :admin do
    # 管理者トップページ(コメント履歴一覧)
    root to: 'homes#top'
    get 'items/search'
    resources :items, except: [:destroy]
      get 'items/:id/reading' => "items#reading", as: "item_reading"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
      get 'customers/:id/comments' => "customers#comments", as: "customer_comments"
    resources :comments, only: [:show, :destroy]
  end

  scope module: :public do
    get 'items/search'
    root to: 'homes#top'
    get 'homes/about'
    get '/customers/:id/my_page' => 'customers#show', as: 'my_page'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    get 'customers/:id/posted' => "customers#posted", as: "customer_posted"
    get 'customers/:id/liked' => "customers#liked", as: "customer_liked"
    resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    get 'items/genre/:id' => "items#genre", as: "items_genre"
    get 'items/:id/reading' => "items#reading", as: "item_reading"
  end

end
