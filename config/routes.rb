Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'random_jokes#index'
  
  get '/new_dad_joke', to: 'random_jokes#new_dad_joke'
  get '/new_official_joke', to: 'random_jokes#new_official_joke'
  get '/new_jokeapi_joke', to: 'random_jokes#new_jokeapi_joke'
  get '/new_geek_joke', to: 'random_jokes#new_geek_joke'

  
  resources :jokes, only: [:create, :index, :destroy]
  delete '/jokes', to: 'jokes#destroy_all', as: :destroy_all_jokes
  



end
