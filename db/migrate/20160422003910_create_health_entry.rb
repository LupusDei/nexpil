class CreateHealthEntry < ActiveRecord::Migration[5.0]
  def change
    create_table :health_entries do |t|

      t.decimal :weight, precision: 5, scale: 2, null: false
      t.decimal :bodyfat, precision: 4, scale: 2, null: false
      t.decimal :muscle_mass, precision: 5, scale: 2, null: false
      t.decimal :heartrate, precision: 3, scale: 1, null: false

      t.timestamps null: false
    end
  end
end
