class AddGroupToEvent < ActiveRecord::Migration
  def change
    add_column :events, :group, :boolean
  end
end
