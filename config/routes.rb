Rails.application.routes.draw do
  root to: 'static_pages#home'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_for :users, skip: :all

  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    post 'signup', to: 'users/registrations#create'
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
  end

  resources :users, except: [:index, :show, :destroy]
  resources :tasks, except: :show do
    patch 'change_status', on: :collection
  end
  resources :labels
end
