Rails.application.routes.draw do
  get 'search/index'

  devise_for :users
  root "staticpages#index"
  resources :income_categories, exept: :show
  resources :expense_categories, exept: :show
  resources :payment_methods, exept: :show
  resources :user_expenses, exept: :show
  resources :user_incomes, exept: :show

  get "details/:type/:interval/:payment_method", to: "staticpages#details", as: :details
  get "search" => "staticpages#search"
  get "export" => "staticpages#export"
end
