Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  patch '/users', to: 'users#update'
  get '/users/edit', to: 'users#edit'
  get '/profile', to: 'users#show'

  get '/users/password/edit', to: 'passwords#edit'
  patch '/users/password', to: 'passwords#update'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    # resources :orders, only: [:update]
    patch '/orders/:id', to: "orders#update", as: 'order'
    # resources :users, only: [:index, :show]
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show', as: 'user'
    # resources :merchants, only: [:index, :show, :update, :destroy]
    get '/merchants', to: 'merchants#index'
    get '/merchants/:id', to: 'merchants#show', as: 'merchant'
    patch '/merchants/:id', to: 'merchants#update', as: 'merchant_update'
    delete '/merchants/:id', to: 'merchants#destroy', as: 'merchant_destroy'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index', as: 'dashboard'
    # resources :items
    get '/items', to: 'items#index'
    post '/items', to: 'items#create'
    get '/items/new', to: 'items#new', as: 'new_item'
    get '/items/:id/edit', to: 'items#edit', as: 'edit_item'
    get '/items/:id/', to: 'items#show', as: 'item'
    patch '/items/:id/', to: 'items#update', as: 'item_update'
    delete '/items/:id/', to: 'items#destroy', as: 'item_destroy'
    # resources :orders, only: [:index, :show] do
    #   resources :items, only: [:update]
    # end
    get '/orders/:id', to: 'orders#show', as: 'order'
    patch '/orders/:order_id/items/:id', to: 'items#update', as: 'order_item_update'
    get '/orders', to: 'orders#index', as: 'orders'
    # resources :item_orders, only: [:update]
    patch '/item_orders/:id', to: 'item_orders#update', as: 'item_order'
  end

  namespace :profile do
    # resources :orders, only: [:index, :show, :destroy]
    get '/orders', to: 'orders#index', as: 'orders'
    get '/orders/:id', to: 'orders#show', as: 'order'
    delete '/orders/:id', to: 'orders#destroy', as: 'order_destroy'
  end

  # resources :merchants do
  #   resources :items, only: [:new, :create, :index]
  # end
  get '/merchants', to: 'merchants#index'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  get '/merchants/:id/edit', to: 'merchants#edit', as: 'edit_merchant'
  get '/merchants/:id/', to: 'merchants#show', as: 'merchant'
  patch '/merchants/:id/', to: 'merchants#update', as: 'merchant_update'
  delete '/merchants/:id/', to: 'merchants#destroy', as: 'merchant_destroy'
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'

  # resources :items, except: [:new, :create] do
  #   resources :reviews, only: [:new, :create]
  # end
  get '/items', to: 'items#index'
  get '/items/:id/edit', to: 'items#edit', as: 'edit_item'
  get '/items/:id/', to: 'items#show', as: 'item'
  patch '/items/:id/', to: 'items#update', as: 'item_update'
  delete '/items/:id/', to: 'items#destroy', as: 'item_destroy'
  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id/reviews', to: 'reviews#create'

  resources :reviews, only: [:edit, :update, :destroy]

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "cart/:item_id", to: "cart#update"

  resources :orders, only: [:new, :create, :show]
end
