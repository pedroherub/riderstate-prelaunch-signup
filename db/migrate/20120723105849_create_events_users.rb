class CreateEventsUsers < ActiveRecord::Migration
  def self.up
    # Create the association table
    create_table :events_users, :id => false do |t|
      t.integer :event_id, :null => false
      t.integer :user_id, :null => false
    end

    # Add table index
    add_index :events_users, [:event_id, :user_id], :unique => true

  end

  def self.down
    remove_index :events_users, :column => [:event_id, :user_id]
    drop_table :events_users
  end
end
