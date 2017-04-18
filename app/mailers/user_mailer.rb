class UserMailer < ApplicationMailer
	def notify_account(user)
		@user = user
		mail to: @user.email, subject: "Bienvenido"
	end
end