class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.references :municipality

      t.timestamps
    end
    add_index :districts, :municipality_id
  end
end
