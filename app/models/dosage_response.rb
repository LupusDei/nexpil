class DosageResponse < ApplicationRecord
  belongs_to :patient
  belongs_to :physician
  belongs_to :health_entry

  def to_s
    "#{self.physician} -> #{self.patient} ~~  #{self.medicine} @ #{self.dosage}"
  end
end
