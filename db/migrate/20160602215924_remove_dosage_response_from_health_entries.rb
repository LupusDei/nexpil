class HealthEntry < ApplicationRecord
  belongs_to :dosage_response
end
class DosageResponse < ApplicationRecord
  belongs_to :health_entry
end

class RemoveDosageResponseFromHealthEntries < ActiveRecord::Migration[5.0]
  def up
    HealthEntry.all.each do |he|
      if he.dosage_response_id != nil
        dr = he.dosage_response
        dr.health_entry_id = he.id
        dr.save
      end
    end
    remove_reference :health_entries, :dosage_response
  end

  def down
    add_reference :health_entries, :dosage_response, foreign_key: true
    HealthEntry.all.each do |he|
      if dr = DosageResponse.where(health_entry_id: he.id).last
        he.dosage_response_id = dr.id
        he.save
      end
    end
  end
end
