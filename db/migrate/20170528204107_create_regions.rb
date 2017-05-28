class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :nombre
      t.text :descripcion
      t.string :imagen

      t.timestamps
    end
  end
end
