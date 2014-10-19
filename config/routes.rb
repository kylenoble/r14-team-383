Rails.application.routes.draw do

  root 'games#index'

  resources :games, only: :index
  match '/games/show/', to: 'games#show', via: [:get, :patch], as: 'show_game'
  match '/sample_game/', to: 'games#sample', via: :get, as: 'sample_game'
  mount Resque::Server, :at => "/admin/resque"

end
