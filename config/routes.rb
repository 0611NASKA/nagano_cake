Rails.application.routes.draw do
  root to: 'public/homes#top'

  get "about"=>"public/homes#about"

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    resources :items, only: [:index, :show]

    get 'customers/my_page' => "customers#show"
    get 'customers/edit' => "customers#edit"
    patch 'customers' => "customers#update"
    get 'customers/unsubscribe' => "customers#unsubscribe"
    patch 'customers/withdraw' => "customers#withdraw"

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_item/destroy_all' => "cart_items#destroy_all"

    resources :oreders, only: [:new, :create, :index, :show]
    post 'orders/confirm' => "orders#confirm"
    get 'orders/complete' => "orders#complete"
  end

  scope module: :customer do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
