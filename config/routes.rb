Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users

  resources :spots

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
