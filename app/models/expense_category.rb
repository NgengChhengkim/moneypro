class ExpenseCategory < ActiveRecord::Base
  has_many :user_expenses
end
