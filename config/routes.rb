Rails.application.routes.draw do
  resources :people
  root 'top#index'
  get 'show' => 'top#show'
end
