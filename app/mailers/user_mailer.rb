class UserMailer < ApplicationMailer
	def notify_account(user)
		@user = user
		mail to: @user.email, subject: "Bienvenido"
	end

	def notify_state(user)
		@user = user
		mail to: @user.email, subject: "Estado de tu cuenta"
	end

end