Rails.application.routes.draw do
  get "admins/index"
  get "home/index"
  get "featured_posts", to: "posts#featured", as: "featured_posts"
  root "home#index"

  namespace :admin do
    get "/", to: "dashboard#index", as: "dashboard"
    resources :posts, only: [:index, :update] do
      member do
        patch :toggle_visibility
        patch :toggle_featured
      end
    end
  end  

  resources :posts
  
  resources :posts do
    resource :post_like, only: [:create, :destroy]
    resources :comments, only: [:new, :create, :index]
    member do
      get :edit_inline
    end
  end

  get 'my_posts', to: 'posts#my_posts'

  devise_for :users
  devise_for :admins
end
