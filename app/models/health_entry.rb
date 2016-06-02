class HealthEntry < ApplicationRecord
  belongs_to :patient
  belongs_to :dosage_response

  attr_accessor :phone_service


  def self.pending
    where(dosage_response_id: nil)
  end

  def self.new_entries_for_physician(physician)
      joins("INNER JOIN dosage_responses ON dosage_responses.patient_id = health_entries.patient_id").
      pending.
      where("dosage_responses.physician_id = ?", physician.id)
  end

  def respond_with_dosage(dosage_response)
    phone_service.send_message(self.patient.phone_number,
      "New Dosage from #{dosage_response.physician}: #{dosage_response.medicine} #{dosage_response.dosage}")
  end

  def previous
    @previous ||= HealthEntry.where(patient: patient).where("created_at < ?", self.created_at).last
  end

  def phone_service
    @phone_service = PhoneService.new
  end
end
