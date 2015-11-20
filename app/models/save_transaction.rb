class SaveTransaction < ActiveRecord::Base
  paginates_per Settings.pagination.per_page
  belongs_to :save_plan

  def self.duration_remain save_plan
    (save_plan.end_date.year - Date.today.year) * 12 - Date.today.month + save_plan.end_date.month
  end

  def method_name
    @save_plan.amount - @save_transaction
  end

end
