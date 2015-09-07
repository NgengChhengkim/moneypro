class UserIncome < ActiveRecord::Base
  belong_to :income_category
  belong_to :payment_method
  belong_to :user
end
