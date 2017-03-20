Rails.application.routes.draw do
  resources :boards
  namespace :api do
    resources :boards do
      resources :cards, except: [:new, :edit]
    end
  end

  root 'boards#index'
end
