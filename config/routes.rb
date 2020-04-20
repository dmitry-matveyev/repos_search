Rails.application.routes.draw do

  root 'repos#index'

  resources :repos, only: %i[index create show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :repos, only: :index
    end
  end
end
