class RenameClubToUser < ActiveRecord::Migration
  def up
    rename_column :users, :club, :club_id
  end

  def down
  end
end
