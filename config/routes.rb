Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dashboard', controller: 'dashboard/application', action: :index, as: :dashboard

  devise_for :user, only: %i[sessions registrations]

  devise_scope :user do
    authenticated  do
      root to: redirect('dashboard')
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  match "*path", to: "dashboard/application#index", format: false, via: :get
end
