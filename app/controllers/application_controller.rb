class ApplicationController < ActionController::Base
  before_action :congiure_permittted_parameters, if: :devise_controller?

  private
  def congiure_permittted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday])
  end
end
