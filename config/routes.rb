Rails.application.routes.draw do
  namespace :api do
    post '/register', to: 'device#register'
    post '/alive', to: 'device#alive'
    post '/report', to: 'device#report'
    patch '/terminate', to: 'device#terminate'
  end
  match '*path', via: [:get, :post, :patch, :puts, :delete], to: 'application#routing_error'
end
