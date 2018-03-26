Rails.application.routes.draw do
  resources :charges, only: [:new, :create]

  devise_for :users
  
  resources :wikis 

  get 'thanks', to: 'charges#thanks', as: 'thanks'

  get 'home/myaccount'

  post 'home', to: 'home#downgrade_account', as: 'downgrade'

  get 'home/index'
  
  root 'home#index'
end
