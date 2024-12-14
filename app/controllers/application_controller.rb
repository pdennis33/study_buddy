class ApplicationController < ActionController::Base
  # Redirect to the root path instead of /sign_in when a session expires
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # Ensure unauthorized users get redirected properly
  def authenticate_user!(options = {})
    if user_signed_in?
      super
    else
      redirect_to root_path, alert: "Please sign in to continue."
    end
  end
end
