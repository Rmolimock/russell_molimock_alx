Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'random_jokes#index'
  get 'random', to: 'random_jokes#index'
  get '/new_dad_joke', to: 'random_jokes#new_dad_joke', as: 'new_dad_joke'

  
  resources :jokes, only: [:create, :index, :destroy]
  delete '/jokes', to: 'jokes#destroy_all', as: :destroy_all_jokes
  



end
