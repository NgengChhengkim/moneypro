Rake::Task["db:migrate:reset"].invoke

User.create name: "Admin",
            email: "admin@gmail.com",
            password: 123456,
            password_confirmation: 123456,
            admin: 1

user = User.create name: "User",
            email: "user@gmail.com",
            password: 123456,
            password_confirmation: 123456,
            admin: 0

payment_methods = ["Cash", "Check", "Visa Card"]
payment_methods.each do |payment_method|
  PaymentMethod.create name: payment_method,
                       description: payment_method,
                       initial_balance: [*100..1000].sample,
                       user_id: 2
end

income_categories = ["Deposits", "Salary", "Saving"]
income_categories.each do |income_category|
  IncomeCategory.create name: income_category,
                       description: income_category,
                       user_id: 2
end

expense_categories = ["Car", "Cloth", "Food","Heallth", "House"]
expense_categories.each do |expense_category|
  ExpenseCategory.create name: expense_category,
                         description: expense_category,
                         user_id: 2
end

date = [2.day.ago, 1.day.ago, Date.today]
10.times do
  UserIncome.create amount: [*100..1000].sample,
                    description: "description",
                    date: date.sample,
                    user_id: 2,
                    income_category: IncomeCategory.all.sample,
                    payment_method: PaymentMethod.all.sample
end

10.times do
  UserExpense.create amount: [*100..1000].sample,
                    description: "description",
                    date: date.sample,
                    user_id: 2,
                    expense_category: ExpenseCategory.all.sample,
                    payment_method: PaymentMethod.all.sample
end
