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
resources :menu_access_logs
resources :tab_clicks
resources :items
resources :promotions

root "admin#admin"
