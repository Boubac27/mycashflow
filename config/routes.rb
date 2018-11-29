Rails.application.routes.draw do
  resources :autocompletes
  devise_for :users
  root to: 'pages#home'

  resources :favorites
  get 'pages/autocomplete', to: 'pages#autocomplete'

  resources :users do
    resources :searches
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

