class SaveTransaction < ActiveRecord::Base
  paginates_per Settings.pagination.per_page
  belongs_to :save_plan

  validates :name, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :date, presence: true
  validate :amount_must_not_exceed_plan_amount_on_create, on: :create
  validate :amount_must_not_exceed_plan_amount_on_update, on: :update
  validate :date_must_lte_save_plan_end_date


  private
  def amount_must_not_exceed_plan_amount_on_create
    if amount.present? && total_save_transaction_on_create > save_plan.amount
      errors.add :amount, "is exceed save plan's amount"
    end
  end

  def amount_must_not_exceed_plan_amount_on_update
    if amount.present? && total_save_transaction_on_update > save_plan.amount
      errors.add :amount, "is exceed save plan's amount"
    end
  end

  def date_must_lte_save_plan_end_date
    if date.present? && date > save_plan.end_date
      errors.add :date, "must be less than or equal save plan's end date"
    end
  end

  def total_save_transaction_on_create
    SaveTransaction.where(save_plan_id: save_plan.id).sum(:amount) + amount
  end

  def total_save_transaction_on_update
    SaveTransaction.where("save_plan_id = ? and id <> ?", save_plan.id, id).sum(:amount) + amount
  end
end
