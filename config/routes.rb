Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/status', to: 'status#index'

      resources :profile, only: [:index, :show, :create, :update]
    end
  end
end
