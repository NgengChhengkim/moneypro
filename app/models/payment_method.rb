class PaymentMethod < ActiveRecord::Base
  has_many :user_incomes
  has_many :user_expenses
end
