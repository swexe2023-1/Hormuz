class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :pid
      t.integer :seller_id
      t.integer :price
      t.string :description
      t.string :img

      t.timestamps
    end
  end
end
