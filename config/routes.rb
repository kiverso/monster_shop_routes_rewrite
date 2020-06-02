Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  patch '/users', to: 'users#update'
  get '/users/edit', to: 'users#edit'
  get '/profile', to: 'users#show'


  namespace :merchant do
    resources :orders, only: [:index, :show] do
      resources :items, only: [:update]
    end
  end

  namespace :profile do
    resources :orders, only: [:index, :show, :update]
  end

  get '/users/password/edit', to: 'passwords#edit'
  patch '/users/password', to: 'passwords#update'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/merchant', to: 'merchant#show', as: 'merchant_dashboard'
  resources :merchants do
    resources :items, only: [:new, :create, :index]
  end

  resources :items, except: [:new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "cart/:item_id", to: "cart#update"

  resources :orders, only: [:new, :create, :show]
end
