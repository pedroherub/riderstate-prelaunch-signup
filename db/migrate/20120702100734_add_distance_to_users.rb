class AddDistanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :distance, :float, :default => 0.0
  end
end
