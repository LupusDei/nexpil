class ChangeUserToPatient < ActiveRecord::Migration[5.0]
  def change
    remove_column :health_entries, :user_id
    add_reference :health_entries, :patient, foreign_key: true

    remove_column :perscriptions, :user_id
    add_reference :perscriptions, :patient, foreign_key: true

    remove_column :dosage_responses, :user_id
    add_reference :dosage_responses, :patient, foreign_key: true
  end
end
