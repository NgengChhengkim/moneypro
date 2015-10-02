class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :description
      t.float :initial_balance, default: 0

      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
    end
  end
end
