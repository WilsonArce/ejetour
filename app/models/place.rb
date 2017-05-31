class Place < ApplicationRecord

	belongs_to :region

	has_attached_file :imagen , styles: { large: "900x700", medium: "600x400", thumb: "500x300", small: "300x100" }
	validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/

end
