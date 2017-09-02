Rails.application.routes.draw do
  root "index#index"
  post "publish"  => "index#publish"
  post "flood"    => "index#flood"
end
