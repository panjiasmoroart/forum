class ApplicationController < ActionController::Base
  include Pundit
  # custom erros messages pundit
  rescue_from Pundit::NotAuthorizedError, with: :pundit_error
  # parameter yang dijakanlan adalah controller yg dibuat oleh devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  private 

  def pundit_error
    flash[:alert] = 'Maaf kamu tidak memiliki hak akses'
    redirect_to root_path
  end

  # devise custom field
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
