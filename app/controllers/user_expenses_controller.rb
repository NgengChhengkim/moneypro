class UserExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_expense, except: [:new, :edit]
  before_action :find_param, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @user_expense = UserExpense.new
  end

  def create
    @user_expense = current_user.user_expenses.build params_user_expense
    @user_expense.save
    flash.now[:success] = t "flash.create"
  end

  def edit
  end

  def update
    @user_expense.update_attributes params_user_expense
    flash.now[:success] = t "flash.update"
  end

  def destroy
    @user_expense.destroy
    flash.now[:alert] = t "flash.delete"
  end

  private
  def params_user_expense
    params.require(:user_expense).permit :amount, :description, :date,
      :payment_method_id, :expense_category_id
  end

  def load_user_expense
    @user_expenses = current_user.user_expenses.order("date").page(params[:page])
  end

  def find_param
    @user_expense = UserExpense.find params[:id]
  end
end
