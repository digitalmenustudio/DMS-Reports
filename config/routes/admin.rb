controller :admin do
  get "/", action: :admin, as: :admin
end

resources :users

root "admin#admin"
