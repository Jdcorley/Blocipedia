Rails.application.routes.draw do
  resources :charges, only: [:new, :create]

  devise_for :users
  
  resources :wikis 

  get 'thanks', to: 'charges#thanks', as: 'thanks'

  get 'home/myaccount'

  post 'downgrade_account', to: 'home#downgrade_account'

  get 'home/index'
  
  root 'home#index'
end
