Rails.application.routes.draw do
  get 'home' => "users#home"

  get 'login' => "users#login"

  get 'register' => "users#register"

  post 'create' => "users#create"

  post '/user/thread/create/comment' => "users#create_comment"

  post '/create/thread' => "users#create_thread"

  get '/user' => "users#index"

  get 'delete_session' => "users#delete_session"

  post 'truelogin' => "users#truelogin"
  
  get 'user/thread/:id' => "users#thread"



  get '/edit/thread/:id' => "users#edit_thread"

  patch '/user/:id' => "users#update_thread"

  delete '/user/:id' => "users#destroy_thread"



  get '/edit/comment/:id' => "users#edit_comment"

  patch 'comment/:id' => "users#update_comment"

  delete '/user/thread/comment/:id' => "users#destroy_comment"



  get 'user/account' => "users#account"

  get 'user/account/edit/:id' => "users#edit_account"

  patch '/user/account/:id' => "users#update_account"

  delete '/user/account/:id' => "users#destroy_account"

  match '*unmatched', to: 'application#route_not_found', via: :all


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
