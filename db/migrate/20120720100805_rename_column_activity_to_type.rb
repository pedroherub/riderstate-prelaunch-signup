class RenameColumnActivityToType < ActiveRecord::Migration
  def up
    rename_column :activities, :activity, :type
  end

  def down
  end
end
