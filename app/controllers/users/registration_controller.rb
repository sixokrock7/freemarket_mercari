class Users::RegistrationController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:new]

  def new
    super
  end

  protected

  def after_sign_up_path_for(resource)
    users_sign_up_address_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
