class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
    @articles = Article.all
  end

  def set_current_account
    @account = Account.find(params[:id])
    current_user.accounts.each do |ac|
      if ac.id == @account.id
        ac.update_attribute(:state, "connected")
      else
        ac.update_attribute(:state, "active")
      end
    end
    redirect_to accounts_path
  end

  def set_state
    @account = Account.find(params[:id])
    if @account.state == "pending" or @account.state == "inactive"
      @account.update_attribute(:state, "active")
      UserMailer.notify_state(@account.user).deliver
    elsif @account.state == "active"
      @account.update_attribute(:state, "inactive")
    end
    redirect_to accounts_path
  end

  def apply_account
    if current_account.role == "subscribed"
      @account = Account.create(user_id: current_user.id, role: "admin",
         state: "pending", location: "utp")
    else
      if current_account.role == "admin"
        @account = Account.create(user_id: current_user.id, role: "root",
         state: "pending", location: "utp")
      end
    end
    redirect_to accounts_path
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    @categories = Category.all
  end

  # GET /accounts/1/edit
  def edit
    @categories = Category.all
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account = current_user.accounts.new(account_params)
    @account.role = params[:role][:name]
    @account.categories = params[:categories]
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      @account.categories = params[:categories]
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:role, :state, :category, :location, :categories)
    end
end
