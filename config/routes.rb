Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'categories#index'

  resources :users, only: [:index, :show] do
    resources :collections, except: :index
  end

  resources :collections, only: [] do
    resources :monuments, except: :index
  end

  resources :monuments, only: [] do
    get :search, on: :collection

    resources :pictures, only: :show
  end
  resources :categories, except: :index
end
