class StaticpagesController < ApplicationController
  before_action :authenticate_user!

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
    @balance = total_income - total_expense

    @daily_chart_data = [
      {name: t("summary.labels.total_income"), y: @daily_income},
      {name: t("summary.labels.total_expense"), y: @daily_expense}
    ]

    @monthly_chart_data = [
      {name: t("summary.labels.total_income"), y: @monthly_income},
      {name: t("summary.labels.total_expense"), y: @monthly_expense}
    ]

    @yearly_chart_data = [
      {name: t("summary.labels.total_income"), y: @yearly_income},
      {name: t("summary.labels.total_expense"), y: @yearly_expense}
    ]

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
    if params[:type] && Settings.types.income == (@type = params[:type][:type_id])
      @q = current_user.user_incomes.ransack params[:q]
      if (id = params[:income][:income_category_id]).present?
        @search_result = @q.result.where(income_category_id: id).group_by{|t| t.date}
      else
        @search_result = @q.result.group_by{|t| t.date}
      end
      @total_income = @q.result.sum :amount
      load_income_expense_data_chart
    elsif params[:type] && Settings.types.expense == (@type = params[:type][:type_id])
      @q = current_user.user_expenses.ransack params[:q]
      if (id = params[:expense][:expense_category_id]).present?
        @search_result = @q.result.where(expense_category_id: id).group_by{|t| t.date}
      else
        @search_result = @q.result.group_by{|t| t.date}
      end
      @total_expense = @q.result.sum :amount
      load_income_expense_data_chart
    else
      @q = current_user.user_incomes.ransack params[:q]
      @expense = current_user.user_expenses.ransack params[:q]
      income_result = @q.result.group_by{|t| t.date}
      expense_result = @expense.result.group_by{|t| t.date}
      @search_result = income_result.merge(expense_result){|k, o, n| o+n}
      @total_income = @q.result.sum :amount
      @total_expense = @expense.result.sum :amount
      # chart data
      income_data = []
      expense_data = []
      @date = []

      @search_result.each do |date, transactions|
        @date << date.to_s
        income_data << transactions.select {|data| data.class.name == Settings.payment_class.user_income}
          .map(&:amount).sum
        expense_data << transactions.select {|data| data.class.name == Settings.payment_class.user_expense}
          .map(&:amount).sum
      end

      @income_expense_data = [
        {name: t("summary.labels.total_income"), data: income_data},
        {name: t("summary.labels.total_expense"), data: expense_data}
      ]
    end
  end

  private
  def load_income_expense_data_chart
    @chart_data = @search_result.collect {|date, data| {name: date.to_s, y: data.map(&:amount).sum, drilldown: date.to_s}}
    @chart_data_detail = @search_result.collect {|date, data| {name: date.to_s, id: date.to_s, data: data.map{|d| [] << d.description << d.amount}}}
  end
end
