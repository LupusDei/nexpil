class HealthEntry < ApplicationRecord
  belongs_to :patient
  has_many :dosage_responses

  validates_uniqueness_of :foreign_key
  validates_presence_of :weight, :bodyfat, :heartrate, :muscle_mass
  attr_accessor :phone_service


  def self.pending
    joins("LEFT OUTER JOIN dosage_responses ON dosage_responses.health_entry_id = health_entries.id")
      .where("dosage_responses.id IS NULL")
  end

  def self.new_entries_for_physician(physician)
      joins("INNER JOIN dosage_responses as drs ON drs.patient_id = health_entries.patient_id").
      pending.
      where("drs.physician_id = ?", physician.id)
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
end
