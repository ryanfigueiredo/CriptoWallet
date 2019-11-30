Rails.application.routes.draw do

  resources :mining_types
  #rota get para welcome/index
  get 'welcome/index'

  #outra forma de escrever uma rota com um alias
  get '/inicio', to: 'welcome#index'

 #resources serve para escrever as 7 rotas de uma vez dos metodos HTTP
  resources :coins

  # root to: manda a rota principal quando acessar ex: localhost:3000
  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
