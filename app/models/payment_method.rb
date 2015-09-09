class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  has_many :user_incomes
  has_many :user_expenses

  validates :name, presence: true
end
