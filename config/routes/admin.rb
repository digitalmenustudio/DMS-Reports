controller :admin do
  get "/", action: :admin, as: :admin
end

resources :users do
  member do
    put :switch_restaurant
  end
end
resources :restaurants
resources :daily_visits

root "admin#admin"
