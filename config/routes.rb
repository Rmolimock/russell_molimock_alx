Rails.application.routes.draw do
  get 'clubs/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'random_jokes#index'
  
  get '/new_dad_joke', to: 'random_jokes#new_dad_joke'
  get '/new_jokeapi_joke', to: 'random_jokes#new_jokeapi_joke'
  get '/new_official_joke', to: 'random_jokes#new_official_joke'
  get '/new_geek_joke', to: 'random_jokes#new_geek_joke'

  
  resources :jokes, only: [:create, :index, :destroy]
  delete '/jokes', to: 'jokes#destroy_all', as: :destroy_all_jokes
  # one path for get that returns the perform index here:
  get '/perform', to: 'perform#index'

  get '/clubs', to: 'clubs#index'

  resources :standup_sets, only: [:create, :index, :destroy] do
    member do
      post 'jokes/:joke_id', to: 'standup_sets#add_joke', as: 'add_joke'
      delete 'jokes/:joke_id', to: 'standup_sets#remove_joke', as: 'remove_joke'
    end
  end
  

end
