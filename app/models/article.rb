class Article < ApplicationRecord

	validates :title, presence: true
	validates :body, presence: true
	has_many :has_categories, :dependent => :destroy
	has_many :categories, through: :has_categories
	after_create :save_categories

	has_attached_file :cover, styles: {medium: "1288x720", thumb: "600x400", small:"300x200"}                                                                                                                                                                                                        
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	def categories=(value)
		@categories = value
	end

	private

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
	end

end
