class SavePlansController < ApplicationController
  before_action :authenticate_user!
  before_action :load_save_plans, except: [:edit, :show]
  before_action :find_param, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @save_plan = SavePlan.new
  end

  def create
    @save_plan = current_user.save_plans.build params_save_plans
    @save_plan.save
    flash.now[:success] = t "flash.create"
  end

  def edit
  end

  def update
    @save_plan.update_attributes params_save_plans
    flash.now[:success] = t "flash.update"
  end

  def destroy
    @save_plan.destroy
    flash.now[:alert] = t "flash.delete"
  end

  private
  def params_save_plans
    params.require(:save_plan).permit :name, :amount, :start_date, :end_date
  end

  def load_save_plans
    @save_plans = current_user.save_plans.page(params[:page])
  end

  def find_param
    @save_plan = SavePlan.find params[:id]
  end
end
