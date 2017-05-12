class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_account
  before_action :set_categories

  def current_account
  	@current_account ||= current_user.accounts.find_by_state("connected")
  end

  def set_categories
  	@categories = Category.all
  end

end
