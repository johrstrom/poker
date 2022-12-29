Rails.application.routes.draw do
  root 'simulations#new'

  # get '/simulations/:id', to: 'simulations#show'
  resource :simulation, only: [:show, :new, :destroy]

end
