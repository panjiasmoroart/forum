Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "forum_threads#index"

  resources :forum_threads, only: [:index, :show, :new, :create, :edit, :update, :destroy] do  
    resources :forum_posts, only: [:index, :create]
    put :pinit, on: :member
  end
end
