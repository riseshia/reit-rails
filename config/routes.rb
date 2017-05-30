Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  root "book#index"

  resources :notes, except: [:show]
  namespace :book do
    post :next
  end
end
