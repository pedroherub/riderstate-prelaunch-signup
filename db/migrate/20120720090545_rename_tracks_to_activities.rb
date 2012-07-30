class RenameTracksToActivities < ActiveRecord::Migration
  def self.up
    rename_table :tracks, :activities
  end
  def self.down
    rename_table :tracks, :activities
  end
end
