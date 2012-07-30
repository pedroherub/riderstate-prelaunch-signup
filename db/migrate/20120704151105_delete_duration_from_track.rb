# -*- encoding : utf-8 -*-
class DeleteDurationFromTrack < ActiveRecord::Migration
  def up
    remove_column :tracks, :duration
  end
end
