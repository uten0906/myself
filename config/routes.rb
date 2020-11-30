Rails.application.routes.draw do

  root "top#index"
  get "about" => "top#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :new, :create] do
    get "search", on: :collection
    get "login_form", on: :collection
    member do
      get :followings, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resource :session, only: [:create, :destroy] do
    post "guest_login", on: :collection
  end
  resource :account, only: [:show, :edit, :update, :destroy]
  resource :password, only: [:show, :edit, :update]

  resources :posts do
    patch "like", "unlike", on: :member
    get "liked", on: :collection
  end

  namespace :admin do
    root "top#index"
    resources :users do
      get "search", on: :collection
    end
    resources :posts
  end
end
