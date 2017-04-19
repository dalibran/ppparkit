Rails.application.routes.draw do

  devise_for :users

  resources :spots, only: [:index, :show] do
  	resources :park_its, only: [:new, :create]
  end

  resources :park_its, only: [:edit, :update]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
