class CreateUserIncomes < ActiveRecord::Migration
  def change
    create_table :user_incomes do |t|
      t.float :amount
      t.string :description
      t.date :date

      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
      t.references :income_category, index: true, foreign_key: true
      t.references :payment_method, index: true, foreign_key: true
    end
  end
end
