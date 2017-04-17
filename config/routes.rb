Rails.application.routes.draw do

  devise_for :users

  resources :reviews
  resources :reports
  resources :street_sect
  resources :rules, only: [:index, :show]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
