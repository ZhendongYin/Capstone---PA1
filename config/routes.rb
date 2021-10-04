Rails.application.routes.draw do
  resources :courses
  resources :subjects
  resources :instructors
  root 'courses#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
