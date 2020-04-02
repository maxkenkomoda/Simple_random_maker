Rails.application.routes.draw do
  root to: 'words#new'
  
  
  resources :words, except: [:index, :show, :update] do
    collection do
      get 'random', to: 'words#random'
      get 'destroy_all', to: 'words#destroy_all'
    end
  end
end