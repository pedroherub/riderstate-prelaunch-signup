class AddOwnerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :owner, :integer
  end
end
