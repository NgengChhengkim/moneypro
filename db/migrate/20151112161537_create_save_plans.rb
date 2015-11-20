class CreateSavePlans < ActiveRecord::Migration
  def change
    create_table :save_plans do |t|
      t.string :name
      t.float :amount
      t.date :start_date
      t.date :end_date

      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
    end
  end
end
