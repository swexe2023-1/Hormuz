class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :aid
      t.string :password

      t.timestamps
    end
  end
end
