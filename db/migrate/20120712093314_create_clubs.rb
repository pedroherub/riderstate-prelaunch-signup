class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :foundation
      t.references :district

      t.timestamps
    end
    add_index :clubs, :district_id
  end
end
