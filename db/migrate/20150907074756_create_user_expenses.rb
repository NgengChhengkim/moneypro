class CreateUserExpenses < ActiveRecord::Migration
  def change
    create_table :user_expenses do |t|
      t.string :amount, default: 0
      t.string :description
      t.date :date

      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
      t.references :expense_category, index: true, foreign_key: true
      t.references :payment_method, index: true, foreign_key: true
    end
  end
end
