class Patient < ApplicationRecord
  has_many :perscriptions, dependent: :destroy
  has_many :health_entries, -> { order(recorded_at: :desc) }, dependent: :destroy
  has_many :recent_health_entries, -> { order(recorded_at: :desc).limit(5) }, class_name: "HealthEntry"
  has_many :dosage_responses, dependent: :destroy

  accepts_nested_attributes_for :perscriptions, allow_destroy: true
  accepts_nested_attributes_for :health_entries, allow_destroy: true

  def to_s
    self.last_name + ", " + self.first_name
  end

  def name
    to_s
  end

  def most_recent_health_entry
    health_entries.first
  end
end
