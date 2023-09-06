Rails.application.routes.draw do
  get 'm_keyword_settings/index'
  root 'home#index'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :posts, only: [:create, :new]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # 【マスタ】サービス設定 m_services
  resources :m_services
end
