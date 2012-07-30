class RenameTypeColumnFromActivities < ActiveRecord::Migration
  def up
    rename_column :activities, :type, :riding_type
  end

  def down
  end
end
