class IncomeCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, except: [:new, :edit]
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @income_category = IncomeCategory.new
  end

  def create
    @income_category = current_user.income_categories.build params_income_categories
    @income_category.save
    flash.now[:success] = t "flash.create"
  end

  def edit
  end

  def update
    @income_category.update_attributes params_income_categories
    flash.now[:success] = t "flash.update"
  end

  def destroy
    @income_category.destroy
    flash.now[:alert] = t "flash.delete"
  end

  private
  def params_income_categories
    params.require(:income_category).permit :name, :description
  end

  def load_category
    @income_categories = current_user.income_categories
  end

  def find_category
    @income_category = IncomeCategory.find params[:id]
  end
end
