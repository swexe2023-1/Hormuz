class CreateMinors < ActiveRecord::Migration[7.0]
  def change
    create_table :minors do |t|
      t.string :nid
      t.integer :middle_id
      t.string :input_type

      t.timestamps
    end
  end
end
