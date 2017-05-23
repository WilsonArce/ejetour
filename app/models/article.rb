class Article < ApplicationRecord

	validates :title, presence: true
	validates :body, presence: true
	has_many :has_categories, :dependent => :destroy
	has_many :categories, through: :has_categories
	after_create :save_categories

	has_attached_file :cover #, :storage => :cloudinary, :path => ':id/:filename', :cloudinary_resource_type => :video
			#, :cloudinary_resource_type => :image 

	validates_attachment_content_type :cover,
		:content_type => ['video/mp4'],
		:message => "Sorry, right now we only support MP4 video",
		:if => :is_type_of_video?
	validates_attachment_content_type :cover,
		:content_type => ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'],
		:message => "Different error message",
		:if => :is_type_of_image?

	def categories=(value)
		@categories = value
	end

	protected

	def is_type_of_video?
		cover.content_type =~ %r(video)
	end

	def is_type_of_image?
		cover.content_type =~ %r(image)
	end


	private

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
	end

end
