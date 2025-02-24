Rails.application.routes.draw do
  get "home", to: "pages#home"
  get "featured", to: "pages#featured"
  resources :posts

  root "pages#home"
end

Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
