class UserMailer < ApplicationMailer
	def notify_login(user)
		@user = user
		mail to: @user.email, subject: "Bienvenido"
	end
end