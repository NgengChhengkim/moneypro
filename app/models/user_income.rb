class UserIncome < ActiveRecord::Base
  belongs_to :income_category
  belongs_to :payment_method
  belongs_to :user

  validates :amount, presence: true, numericality: greater_than: 0
end
