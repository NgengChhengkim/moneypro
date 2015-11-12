class SavePlan < ActiveRecord::Base
  paginates_per Settings.pagination.per_page
  belongs_to :user

  has_many :save_transactions, dependent: :destroy

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :end_date, presence: true
  validates :name, presence: true
  validates :start_date, presence: true

end
