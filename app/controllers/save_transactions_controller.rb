class SaveTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_save_transaction, except: [:new, :edit]
  before_action :find_param_save_plan
  before_action :find_param_save_transaction, only: [:edit, :update, :destroy]

  def index
    @save_transaction = SaveTransaction.where(save_plan_id: @save_plan).sum(:amount)
    @duration_remain = SaveTransaction.duration_remain @save_plan
  end

  def new
    @save_transaction = SaveTransaction.new
  end

  def create
    @save_transaction = @save_plan.save_transactions.build params_save_transactions
    @save_transaction.save
    @total_save_transaction = @save_plan.save_transactions.sum(:amount)
    flash.now[:success] = t "flash.create"
    redirect_to save_plan_save_transactions_path
  end

  def edit
  end

  def update
    @save_transaction.update_attributes params_save_transactions
    flash.now[:success] = t "flash.update"
    redirect_to save_plan_save_transactions_path
  end

  def destroy
    @save_transaction.destroy
    flash.now[:alert] = t "flash.delete"
    redirect_to save_plan_save_transactions_path
  end

  private
  def params_save_transactions
    params.require(:save_transaction).permit :name, :amount, :description, :date
  end

  def load_save_transaction
    find_param_save_plan
    @save_transactions = @save_plan.save_transactions.page(params[:page])
  end

  def find_param_save_plan
    @save_plan = SavePlan.find params[:save_plan_id]
  end

  def find_param_save_transaction
    @save_transaction = SaveTransaction.find params[:id]
  end

end
