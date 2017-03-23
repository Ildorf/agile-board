Rails.application.routes.draw do
  devise_for :users

  resources :boards, only: [:index, :show]

  namespace :api do
    resources :boards, only: [:index, :create, :destroy, :update] do
      resources :cards, except: [:new, :edit] do
        patch :move, on: :member
      end
    end
  end

  root 'boards#index'
end
