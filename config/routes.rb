Rails.application.routes.draw do
  namespace :api do
    post '/register', to: 'device#register'
    post '/alive', to: 'device#alive'
    post '/report', to: 'device#report'
    patch '/terminate', to: 'device#terminate'
    get '/all', to: 'device#index'
  end
end
