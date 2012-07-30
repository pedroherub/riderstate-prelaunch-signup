class DropUsersEventsTable < ActiveRecord::Migration
  def up
    drop_table :users_events
  end

  def down
  end
end
