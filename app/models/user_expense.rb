class UserExpense < ActiveRecord::Base
  belong_to :expense_category
  belong_to :payment_method
  belong_to :user
end
