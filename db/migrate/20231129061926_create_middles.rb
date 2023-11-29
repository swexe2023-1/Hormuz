class CreateMiddles < ActiveRecord::Migration[7.0]
  def change
    create_table :middles do |t|
      t.string :did
      t.integer :up_middle_id
      t.integer :major_id

      t.timestamps
    end
  end
end
