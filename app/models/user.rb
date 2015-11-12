class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable, :recoverable

  has_many :payment_methods
  has_many :user_expenses, dependent: :destroy
  has_many :expense_categories
  has_many :income_categories
  has_many :save_plans, dependent: :destroy
  has_many :user_incomes, dependent: :destroy
end
