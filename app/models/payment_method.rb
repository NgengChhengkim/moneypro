class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  has_many :user_incomes
  has_many :user_expenses

  validates :name, presence: true
  validates :initial_balance, numericality: {greater_than_or_equal: 0}
end
