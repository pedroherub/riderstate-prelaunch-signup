# -*- encoding : utf-8 -*-
class DeleteHeartbeatsFromTrack < ActiveRecord::Migration
  def change
    remove_column :tracks, :heartbeats
  end
end
