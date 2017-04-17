class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.bigint :user_id
      t.string :role
      t.string :state
      t.string :category
      t.string :location

      t.timestamps
    end
  end
end
