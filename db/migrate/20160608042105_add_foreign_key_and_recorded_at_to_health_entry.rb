class AddForeignKeyAndRecordedAtToHealthEntry < ActiveRecord::Migration[5.0]
  def change
    change_table :health_entries do |t|
      t.string :foreign_key
      t.datetime :recorded_at
    end
  end
end
