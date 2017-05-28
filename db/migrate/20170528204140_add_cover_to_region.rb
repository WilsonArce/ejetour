class AddCoverToRegion < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :regions, :imagen
  end
end
