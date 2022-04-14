Rails.application.routes.draw do
  get '/pairs/sort', to: 'pairs#sort_pairing'
  resources :pairs
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
