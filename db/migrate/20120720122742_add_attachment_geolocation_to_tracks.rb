class AddAttachmentGeolocationToTracks < ActiveRecord::Migration
  def self.up
    change_table :tracks do |t|
      t.has_attached_file :geolocation
    end
  end

  def self.down
    drop_attached_file :tracks, :geolocation
  end
end
