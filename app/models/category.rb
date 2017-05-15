class Category < ApplicationRecord
	validates :name, presence: true

	has_many :has_categories
	has_many :articles, through: :has_categories

	has_many :preferences
	has_many :accounts, through: :preferences

end
