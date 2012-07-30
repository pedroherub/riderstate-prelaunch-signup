class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :activity

      t.timestamps
    end
    add_index :tracks, :activity_id
  end
end
