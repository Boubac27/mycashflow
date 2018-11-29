Rails.application.routes.draw do
  get 'progresses/index'
  resources :autocompletes
  devise_for :users
  root to: 'pages#home'


  get 'pages/autocomplete', to: 'pages#autocomplete'

  resources :users do
    resources :searches
    resources :progresses, only: :index
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

