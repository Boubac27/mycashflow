Rails.application.routes.draw do
  resources :autocompletes
  devise_for :users
  root to: 'pages#home'

  get 'pages/autocomplete', to: 'pages#autocomplete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
