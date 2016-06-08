class AddHealthEntryToDosageResponses < ActiveRecord::Migration[5.0]
  def change
    add_reference :dosage_responses, :health_entry, foreign_key: true, indexed: true
  end
end
