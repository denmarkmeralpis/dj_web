DjWeb::Engine.routes.draw do
  root to: 'pages#index'

  resources :pages, only: %i[index show destroy]
  resources :jobs do
    collection do
      get :enqueued
      get :pending
      get :working
      get :failed
      patch :reload_all
      delete :destroy_all
    end

    member do
      patch :retry
      patch :reload
    end
  end
end

