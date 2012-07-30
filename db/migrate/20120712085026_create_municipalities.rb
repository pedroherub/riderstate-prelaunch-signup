class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities do |t|
      t.string :name
      t.references :region

      t.timestamps
    end
    add_index :municipalities, :region_id
  end
end
