class StaticpagesController < ApplicationController
  def index
    if params[:payment_method] && (@payment_method_id = params[:payment_method][:payment_method_id]).present?
      total_initial_balance = PaymentMethod.find(@payment_method_id).initial_balance
    else
      @payment_method_id = Settings.payment_methods.all
      total_initial_balance = PaymentMethod.total_initial_balance
    end
    @daily_income = UserIncome.daily_income(@payment_method_id, current_user).sum :amount
    @daily_expense = UserExpense.daily_expense(@payment_method_id, current_user).sum :amount

    @monthly_income = UserIncome.monthly_income(@payment_method_id, current_user).sum :amount
    @monthly_expense = UserExpense.monthly_expense(@payment_method_id, current_user).sum :amount

    @yearly_income = UserIncome.yearly_income(@payment_method_id, current_user).sum :amount
    @yearly_expense = UserExpense.yearly_expense(@payment_method_id, current_user).sum :amount

    total_income = UserIncome.total_income(@payment_method_id, current_user).sum(:amount) + total_initial_balance
    total_expense = UserExpense.total_expense(@payment_method_id, current_user).sum(:amount)
    @daily_balance = total_income - total_expense
  end

  def details
    @type = params[:type]
    @interval = params[:interval]
    @payment_method_id = params[:payment_method]
    if Settings.types.income == @type
      transaction = UserIncome.send("#{@interval}_income", @payment_method_id, current_user)
      @transaction_detail = transaction.group_by{|t| t.date}
      @total = transaction.sum :amount
    elsif Settings.types.expense == @type
      transaction = UserExpense.send("#{@interval}_expense", @payment_method_id, current_user)
      @transaction_detail = transaction.group_by{|t| t.date}
      @total = transaction.sum :amount
    end
  end

  def search
    @sea = User.ransack(params[:q])
  end
end
