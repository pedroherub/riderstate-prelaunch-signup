class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starting
      t.string :type
      t.string :publish

      t.timestamps
    end
  end
end
