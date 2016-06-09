class HealthEntry < ApplicationRecord
  belongs_to :patient
  has_many :dosage_responses
  has_one :dosage_response, -> { order(created_at: :desc) }

  validates_uniqueness_of :foreign_key, allow_nil: true
  validates_presence_of :weight, :bodyfat, :heartrate, :muscle_mass
  attr_accessor :phone_service


  def self.most_recent
    joins("INNER JOIN (SELECT patient_id, MAX(recorded_at) AS recent_date
      FROM health_entries
      GROUP BY patient_id
      ) AS recent ON health_entries.patient_id = recent.patient_id
      AND health_entries.recorded_at = recent.recent_date")
  end

  def self.pending
    joins("LEFT OUTER JOIN dosage_responses ON dosage_responses.health_entry_id = health_entries.id")
      .where("dosage_responses.id IS NULL").most_recent
  end

  def self.new_entries_for_physician(physician)
      joins("INNER JOIN dosage_responses as drs ON drs.patient_id = health_entries.patient_id").
      pending.
      where("drs.physician_id = ?", physician.id).distinct(&:id)
  end


  def respond_with_dosage(dosage_response)
    phone_service.send_message(self.patient.phone_number,
      "New Dosage from #{dosage_response.physician}: #{dosage_response.medicine} #{dosage_response.dosage}")
  end

  def previous
    @previous ||= HealthEntry.where(patient: patient)
      .where("created_at < ?", self.created_at).last
  end

  def phone_service
    @phone_service = PhoneService.new
  end

  def display_weight
    "#{weight.round(2)}kg (#{in_lbs(weight).round(2)}lbs)"
  end

  def display_muscle_mass
    "#{muscle_mass.round(2)}kg (#{in_lbs(muscle_mass).round(2)}lbs)"
  end

  def in_lbs(mass)
    mass * 2.20462
  end
end
