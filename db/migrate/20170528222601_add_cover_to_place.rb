class AddCoverToPlace < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :places, :imagen
  end
end
