class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_account

  def current_account
  	@current_account ||= current_user.accounts.find_by_state("connected")
  end

end
