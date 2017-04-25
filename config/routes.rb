Rails.application.routes.draw do

  get 'errors/not_found'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: :update
  resources :spots, only: [:index, :show, :update] do
  	resources :park_its, only: [:create]
  end

  resources :park_its, only: [:edit, :update]

  root "pages#landing_page"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
