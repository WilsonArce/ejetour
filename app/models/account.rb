class Account < ApplicationRecord
	belongs_to :user

	has_many :preferences, :dependent => :destroy
	has_many :categories, through: :preferences

	after_create :save_categories
	after_update :update_categories

	def categories=(value)
		@categories = value
	end

	private

	def save_categories
		if @categories != nil
			@categories.each do |category_id|
				Preference.create(category_id: category_id, account_id: self.id)
			end
		end
	end

	def update_categories
		if @categories != nil
			Preference.where(account_id: self.id).destroy_all
			@categories.each do |category_id|
				Preference.create(category_id: category_id, account_id: self.id)
			end
		end
	end

end
