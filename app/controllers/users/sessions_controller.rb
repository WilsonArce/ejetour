class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :set_account_state, :only => :destroy

  def  after_sign_in_path_for(resource)
    super(resource)
    account = current_user.accounts.find_by_state("active")
    if account
      account.update_attribute(:state, "connected")
    end
    if current_account
      root_path
    else
      '/home/info'
    end
  end

  def set_account_state
    current_user.accounts.each do |ac|
      unless ac.state == "pending" || ac.state == "inactive"
        ac.update_attribute(:state, "active")
        #current_account.update_attribute(:state, "active")
      end
    end
    #redirect_to accounts_path
  end



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
