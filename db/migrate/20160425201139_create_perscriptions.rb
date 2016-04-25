class CreatePerscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :perscriptions do |t|
      t.references :user, foreign_key: true
      t.string :medicine
      t.string :dosage

      t.timestamps
    end
  end
end
