Rails.application.routes.draw do
  devise_for :users

  concern :localizable do
    put :change_locale, controller: "application"
  end

  # Admin routes (already handled)
  scope :admin, module: :admin, as: :admin do
    concerns :localizable
    draw :admin
  end

  # Web routes
  scope "/", module: :web, as: :web do
    concerns :localizable
    draw :web
  end

  # Redirect based on authentication status
  authenticated :user do
    root to: 'web/sites#home', as: :authenticated_root
  end

  unauthenticated do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end
end
