class CreateSaveTransactions < ActiveRecord::Migration
  def change
    create_table :save_transactions do |t|
      t.string :name
      t.float :amount
      t.string :description
      t.date :date

      t.timestamps null: false

      t.references :save_plan, index: true, foreign_key: true
    end
  end
end
