Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "announcements#index"

  resources :announcements, except: [:edit, :update]

  resources :events, except: [:edit, :update]

  get '/dashboard/', to: "pages#dashboard"

  patch '/admins/:id', to: "pages#update", as: :update_admin
end
