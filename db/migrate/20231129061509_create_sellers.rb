class CreateSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
      t.string :sid
      t.string :store_name
      t.string :password
      t.string :address
      t.integer :phone

      t.timestamps
    end
  end
end
