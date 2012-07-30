class RenameTypeColumnFromEvents < ActiveRecord::Migration
  def up
    rename_column :events, :type, :riding_type
  end

  def down
  end
end
