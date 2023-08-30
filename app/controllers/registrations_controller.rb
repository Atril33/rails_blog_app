class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
  
    # Other actions...
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
  end
  