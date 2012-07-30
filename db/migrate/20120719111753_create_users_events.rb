class CreateUsersEvents < ActiveRecord::Migration
  def self.up
    # Create the association table
    create_table :users_events, :id => false do |t|
      t.integer :user_id, :null => false
      t.integer :event_id, :null => false
    end

    # Add table index
    add_index :users_events, [:user_id, :event_id], :unique => true

  end

  def self.down
    remove_index :users_events, :column => [:user_id, :event_id]
    drop_table :users_events
  end
end
