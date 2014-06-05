Rails.application.routes.draw do

  root :to => "visitors#index"

  protected_resque = Rack::Auth::Basic.new(Resque::Server) do |username, password|
    username == 'testcloud' && password == 'iabtidb76ib'
  end
  mount protected_resque, at: '/resque'

  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'


  get :please_login, :to => 'visitors#please_login'

  post :log_invitation, :to => 'visitors#log_invitation'

  resources :bets
  resources :chat_messages, :only => [:create]

  get :pending_games, to: 'visitors#pending_games'
  get :current_games, to: 'visitors#current_games'
  get :next_game,     to: 'visitors#next_game'
  get :past_games,    to: 'visitors#past_games'
  get :ranking,       to: 'visitors#ranking'

end
