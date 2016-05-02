class DosageResponse < ApplicationRecord
  belongs_to :patient
  belongs_to :physician

  def to_s
    "#{self.physician} -> #{self.patient} ~~  #{self.medicine} @ #{self.dosage}"
  end
end
