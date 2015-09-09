class ExpenseCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, except: [:new, :edit]
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @expense_category = ExpenseCategory.new
  end

  def create
    @expense_category = current_user.expense_categories.build params_expense_category
    @expense_category.save
    flash.now[:success] = t "flash.create"
  end

  def edit
  end

  def update
    @expense_category.update_attributes params_expense_category
    flash.now[:success] = t "flash.update"
  end

  def destroy
    @expense_category.destroy
    flash.now[:alert] = t "flash.delete"
  end

  private
  def params_expense_category
    params.require(:expense_category).permit :name, :description
  end

  def load_category
    @expense_categories = current_user.expense_categories
  end

  def find_category
    @expense_category = ExpenseCategory.find params[:id]
  end
end
