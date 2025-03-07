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

  resources :posts # This already includes new, create, index, edit, update, destroy
  
  get 'my_posts', to: 'posts#my_posts' # New route for user's posts  

  devise_for :users
  devise_for :admins
end
