class DosageResponse < ApplicationRecord
  belongs_to :user
  belongs_to :physician

  def to_s
    "#{self.physician} -> #{self.user} ~~  #{self.medicine} @ #{self.dosage}"
  end
end
