class ApplicationController < ActionController::Base

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protect_from_forgery with: :exception

  private

  def check_admin
  	current_user and current_user.admin?
  end

  def check_admin_and_redirect
    redirect_to new_user_session_path unless check_admin
	end
end