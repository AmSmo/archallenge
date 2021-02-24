Rails.application.routes.draw do
  namespace :api do
    post '/register', to: 'phone#register'
    post '/alive', to: 'phone#alive'
    post '/report', to: 'phone#report'
    patch '/terminate', to: 'phone#terminate'
    get '/all', to: 'phone#index'
  end
end
