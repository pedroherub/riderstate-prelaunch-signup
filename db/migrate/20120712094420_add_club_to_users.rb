class AddClubToUsers < ActiveRecord::Migration
  def change
    add_column :users, :club, :integer, :null => true
  end
end

