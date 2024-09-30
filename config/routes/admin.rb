controller :admin do
  get "/", action: :admin, as: :admin
end

resources :users
resources :restaurants

root "admin#admin"
