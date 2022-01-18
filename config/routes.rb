Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :contacts, only: [:index, :update, :destroy, :create] do
    resources :changes, only: [:index]
  end
end
