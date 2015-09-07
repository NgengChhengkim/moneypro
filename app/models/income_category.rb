class IncomeCategory < ActiveRecord::Base
  belongs_to :user
  has_many :user_incomes

  validates :name, presence: true
end
