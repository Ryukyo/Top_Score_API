Rails.application.routes.draw do
  resources :scores, only: [:index, :show, :create, :destroy]
end
