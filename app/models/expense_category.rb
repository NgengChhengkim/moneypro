class ExpenseCategory < ActiveRecord::Base
  belongs_to :user
  has_many :user_expenses

  validates :name, presence: true
end
