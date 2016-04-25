class Physician < ApplicationRecord
  has_many :dosage_responses

  accepts_nested_attributes_for :dosage_responses, allow_destroy: true

  def to_s
    "Dr. #{self.first_name} #{self.last_name}"
  end
end
