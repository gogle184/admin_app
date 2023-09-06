Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :posts, only: [:create, :new]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # 【マスタ】サービス設定 m_services
  resources :m_services
  # 【マスタ】コンテンツを検索するための情報(キーワード、除外系) m_keyword_setting
  resources :m_keyword_settings
  #【マスタ】コンテンツを検索するための情報(キーワード) m_keyword
  resources :m_keywords
end
