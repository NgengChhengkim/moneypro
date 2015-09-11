class UserIncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_incomes, except: [:new, :edit]
  before_action :find_param, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @user_income = UserIncome.new
  end

  def create
    @user_income = current_user.user_incomes.build params_user_income
    @user_income.save
    flash.now[:success] = t "flash.create"
  end

  def edit
  end

  def update
    @user_income.update_attributes params_user_income
    flash.now[:success] = t "flash.update"
  end

  def destroy
    @user_income.destroy
    flash.now[:alert] = t "flash.delete"
  end

  private
  def params_user_income
    params.require(:user_income).permit :amount, :description, :date,
      :payment_method_id, :income_category_id
  end

  def load_user_incomes
    @user_incomes = current_user.user_incomes.order("date").page(params[:page])
  end

  def find_param
    @user_income = UserIncome.find params[:id]
  end
end
