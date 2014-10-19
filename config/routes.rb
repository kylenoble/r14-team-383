Rails.application.routes.draw do

  root 'games#index'

  resources :games, only: :index
  match '/sample_game/', to: 'games#sample', via: :get, as: 'sample_game'

end
