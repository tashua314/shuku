Rails.application.routes.draw do
  root 'top#index'
  get 'show' => 'top#show'
end
