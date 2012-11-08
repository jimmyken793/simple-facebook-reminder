class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.string :title
      t.integer :period
      t.datetime :start_time
      t.integer :type

      t.timestamps
    end
  end
end
