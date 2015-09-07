class CreateIncomeCategories < ActiveRecord::Migration
  def change
    create_table :income_categories do |t|
      t.string :name
      t.string :description

      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
    end
  end
end
