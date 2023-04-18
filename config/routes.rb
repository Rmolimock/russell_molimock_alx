Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'random_jokes#index'
  get 'random', to: 'random_jokes#index'

  resources :jokes, only: [:create, :index]

end
