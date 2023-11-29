class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :password
      t.string :last_name
      t.string :name
      t.string :gender
      t.string :address
      t.integer :phone_number
      t.date :birth
      t.integer :profile_id

      t.timestamps
    end
  end
end
