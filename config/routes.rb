Rails.application.routes.draw do
  resources :categories do
		resources :products do
		  resources :reviews
		end
  end

  get "/products" => 'products#index'

  devise_for :users

  root 'categories#index'
end
