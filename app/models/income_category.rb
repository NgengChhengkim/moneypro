class IncomeCategory < ActiveRecord::Base
  has_many :user_incomes
end
