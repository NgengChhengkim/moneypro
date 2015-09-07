class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  include ApplicationHelper

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push :name
    devise_parameter_sanitizer.for(:account_update).push :name
  end
end
