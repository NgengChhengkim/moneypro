Rails.application.routes.draw do
  devise_for :users
  root "staticpages#index"
  resources :income_categories, exept: :show
  resources :expense_categories, exept: :show
  resources :payment_methods, exept: :show
  resources :user_expenses, exept: :show
  resources :user_incomes, exept: :show
end
