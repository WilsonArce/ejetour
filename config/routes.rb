Rails.application.routes.draw do
  resources :users_roles
  resources :roles
  resources :accounts

  get "/home/info" => "home#info", :as => :info

  root 'home#index'

  devise_for :users, controllers:{ registrations: 'users/registrations', sessions: 'users/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
