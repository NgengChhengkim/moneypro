Rails.application.routes.draw do
  devise_for :users
  root "staticpages#index"
  resources :income_categories, exept: :show
end
