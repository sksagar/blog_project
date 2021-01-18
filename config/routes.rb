Rails.application.routes.draw do
  resources :tags
  mount Ckeditor::Engine => '/ckeditor'
  resources :articles
  resources :users
  resources :sessions
  resources :comments

  
  root "home#index"
  get 'home', to: "home#index"
 

  get 'login', to: 'sessions#new', as: "login"
  get 'logout', to: 'sessions#destroy', as: "logout"
  get 'signup', to: 'users#new',as: "signup"
  
  get 'edit', to: 'profile#edit',as: "edit"

  put '/profile/update', to: 'profile#update'

  get 'home_show/:id',to: 'home#show_articles',as: 'home_show'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
