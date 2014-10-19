Rails.application.routes.draw do

  root 'games#index'

  resources :games, only: :index
  match '/games/show/', to: 'games#show', via: [:get, :patch], as: 'show_game'
  match '/view_game/', to: 'games#view', via: [:get, :patch], as: 'view_game'
  mount Resque::Server, :at => "/admin/resque"

end
