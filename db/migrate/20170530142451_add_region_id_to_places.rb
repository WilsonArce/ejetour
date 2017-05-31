class AddRegionIdToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_reference :places, :region, foreign_key: true
  end
end
