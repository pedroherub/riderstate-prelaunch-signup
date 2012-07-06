class AddDurationToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :duration_hours, :integer, :default => 0
    add_column :tracks, :duration_minutes, :integer, :default => 0
  end
end
