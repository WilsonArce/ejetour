class User < ApplicationRecord
	has_many :accounts, :dependent => :destroy
	has_many :users_roles, :dependent => :destroy
	has_many :roles, through: :users_roles

	after_create :set_role

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	def roles=(value)
		@roles = value
	end

	def set_role
		role = Role.find_by_name("subscribed")
		UsersRole.create(role_id: role.id, user_id: self.id)
		Account.create(user_id: self.id, role: role.name, state: "pending", location: "utp")
		UserMailer.notify_account(self).deliver
	end

end
