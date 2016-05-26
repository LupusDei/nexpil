class AddDosageResponseReferenceToHealthEntry < ActiveRecord::Migration[5.0]
  def change
    add_reference :health_entries, :dosage_response, foreign_key: true
  end
end
