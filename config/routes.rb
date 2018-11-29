Rails.application.routes.draw do
  resources :autocompletes
  devise_for :users
  root to: 'pages#home'


  get 'pages/autocomplete', to: 'pages#autocomplete'
  get 'results_details', to: 'results_details#results_details'

  resources :users do
    resources :searches
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

