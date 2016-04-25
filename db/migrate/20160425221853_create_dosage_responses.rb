class CreateDosageResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :dosage_responses do |t|
      t.string :dosage
      t.string :medicine
      t.references :user, foreign_key: true
      t.references :physician, foreign_key: true

      t.timestamps
    end
  end
end
