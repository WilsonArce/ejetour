Rails.application.routes.draw do
  resources :users_roles
  resources :roles
  resources :accounts

  get "/home/info" => "home#info", :as => :info
  post "/accounts/set_current_account/:id" => "accounts#set_current_account", :as => :set_current_account
  post "/accounts/set_state/:id" => "accounts#set_state", :as => :set_state
  post "/accounts/apply_account" => "accounts#apply_account", :as => :applyAccount

  root 'home#index'

  devise_for :users, controllers:{ registrations: 'users/registrations', sessions: 'users/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
