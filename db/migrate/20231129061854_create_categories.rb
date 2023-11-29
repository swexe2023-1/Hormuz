class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.integer :product_id
      t.string :key_word

      t.timestamps
    end
  end
end
