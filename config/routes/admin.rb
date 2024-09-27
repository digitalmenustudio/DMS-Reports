controller :admin do
  get "/", action: :admin, as: :admin
end

root "admin#admin"
