class SaveTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_save_transaction, except: [:new, :edit]
  before_action :find_param_save_plan
  before_action :find_param_save_transaction, only: [:edit, :update, :destroy]
  before_action :correct_user

  def index
    load_statistic
  end

  def new
    @save_transaction = SaveTransaction.new
  end

  def create
    @save_transaction = @save_plan.save_transactions.build params_save_transactions
    @save_transaction.save
    @total_save_transaction = @save_plan.save_transactions.sum(:amount)
    flash.now[:success] = t "flash.create"
    load_statistic
  end

  def edit
  end

  def update
    @save_transaction.update_attributes params_save_transactions
    flash.now[:success] = t "flash.update"
    load_statistic
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

  def load_statistic
    @save_transaction_amount = @save_plan.save_transactions.sum :amount
    @duration_remain = @save_plan.duration_remain
    @remain_amount =  @save_plan.amount - @save_transaction_amount
    # @save_need = @remain_amount / @duration_remain
  end

  def correct_user
    redirect_to root_url unless @save_plan.user == current_user
  end

end
