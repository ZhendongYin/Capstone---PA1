Rails.application.routes.draw do
  root 'courses#index'

  get :search, to: 'search#index'
  post :search, to: 'search#index'

  resources :courses
  resources :subjects
  resources :instructors

  resources :users do
    collection do
      post :register_course
      post :drop_course
    end
  end
  resources :sessions do
    collection do
      get :login
      delete :destroy
    end
  end

  # resources :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
