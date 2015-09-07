Rails.application.routes.draw do
  devise_for :users
  root "staticpages#index"
end
