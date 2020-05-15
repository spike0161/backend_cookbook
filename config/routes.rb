Rails.application.routes.draw do
resources :users, only: [:index, :show, :create]

resources :reviews, only: [:index, :create, :destroy, :edit]

resources :recipes
post '/favoriterecipe', to: 'recipes#favorite'

resources :ingredients
post '/login', to: 'users#login'

delete '/favoriterecipe/:user_id/:recipe_id', to: 'recipes#destroy'

end
