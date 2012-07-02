class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :activity
      t.datetime :departing
      t.time :duration
      t.float :distance
      t.integer :heartbeats
      t.float :burnedcalories
      t.string :feeling
      t.string :weather
      t.string :notes
      t.references :user

      t.timestamps
    end

    add_index :tracks, :user_id
  end
end
