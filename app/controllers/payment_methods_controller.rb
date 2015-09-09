class PaymentMethodsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, except: [:new, :edit]
  before_action :find_param, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = current_user.payment_methods.build params_payment_method
    @payment_method.save
    flash.now[:success] = t "flash.create"
  end

  def edit
  end

  def update
    @payment_method.update_attributes params_payment_method
    flash.now[:success] = t "flash.update"
  end

  def destroy
    @payment_method.destroy
    flash.now[:alert] = t "flash.delete"
  end

  private
  def params_payment_method
    params.require(:payment_method).permit :name, :description
  end

  def load_category
    @payment_methods = current_user.payment_methods
  end

  def find_param
    @payment_method = PaymentMethod.find params[:id]
  end
end
