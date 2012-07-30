# -*- encoding : utf-8 -*-
class RemoveDistanceToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :distance
  end
end
