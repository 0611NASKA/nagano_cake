Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  get 'my_page' => "public/customers#show"

  resources :customers, only: [:edit, :update] do
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top"
  end
end
