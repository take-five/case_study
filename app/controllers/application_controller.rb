class ApplicationController < ActionController::Base
  PermissionDenied = Class.new(RuntimeError)

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from PermissionDenied, with: :handle_permission_denied

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def handle_permission_denied
    if user_signed_in?
      redirect_to root_path, :alert => 'Permission denied'
    else
      authenticate_user!
    end
  end

  # Declarative_authorization calls this method in case of access violation.
  # We just raise exception so it'd be easier to test.
  # Exception is handled with #handle_permission_denied.
  def permission_denied
    raise PermissionDenied
  end
end
