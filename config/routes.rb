Rails.application.routes.draw do
  root "book#index"

  resources :notes
  namespace :book do
    post :next
  end
end
