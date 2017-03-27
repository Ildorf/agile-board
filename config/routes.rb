Rails.application.routes.draw do
  devise_for :users

  resources :boards, only: [:index, :show]

  namespace :api do
    resources :boards, only: [:index, :create, :destroy, :update] do
      resources :cards, except: [:new, :edit] do
        patch :move, on: :member
        resources :card_marks, only: [:create, :destroy]
      end
      resources :participations, only: [:create, :destroy, :update]
    end
  end

  root 'boards#index'
end
