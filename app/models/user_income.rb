class UserIncome < ActiveRecord::Base
  paginates_per Settings.pagination.per_page

  belongs_to :income_category
  belongs_to :payment_method
  belongs_to :user

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :date, presence: true

  delegate :name, to: :income_category, prefix: true, allow_nil: true
  delegate :name, to: :payment_method, prefix: true, allow_nil: true
end
