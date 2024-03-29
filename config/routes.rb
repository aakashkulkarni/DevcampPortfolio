Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :topics, only: [:index, :show, :edit, :update, :create, :destroy, :new]
  resources :portfolios, only: [:destroy]
  resources :skills, only: [:show, :edit, :update, :create, :destroy, :new]

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end
  get 'angular-items', to: 'portfolios#angular'
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'
  patch 'portfolio/:id', to: 'portfolios#update'
  put 'portfolio/:id', to: 'portfolios#update'

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'tech-news', to: 'pages#tech_news'

  resources :blogs do
    member do
      get :toggle_status
    end
  end
  
  mount ActionCable.server => '/cable'
  
  root to: 'pages#home'
end
