class CreatePurchaseds < ActiveRecord::Migration[7.0]
  def change
    create_table :purchaseds do |t|
      t.integer :user_id
      t.integer :seller_id
      t.integer :product_id

      t.timestamps
    end
  end
end
