class User < ApplicationRecord
  has_many :perscriptions
  has_many :health_entries
  has_many :dosage_responses

  accepts_nested_attributes_for :perscriptions, allow_destroy: true
  accepts_nested_attributes_for :health_entries, allow_destroy: true

  def to_s
    self.first_name + " " + self.last_name
  end
end
