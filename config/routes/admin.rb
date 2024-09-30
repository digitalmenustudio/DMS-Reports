controller :admin do
  get "/", action: :admin, as: :admin
end

resources :users do
  member do
    put :switch_restaurant
  end
end
resources :restaurants

root "admin#admin"
