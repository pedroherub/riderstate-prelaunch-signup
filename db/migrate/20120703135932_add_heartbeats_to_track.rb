# -*- encoding : utf-8 -*-
class AddHeartbeatsToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :heartbeats_average, :float
    add_column :tracks, :heartbeats_max, :float
  end
end
