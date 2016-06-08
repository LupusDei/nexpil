require 'test_helper'

class HealthEntryTest < ActiveSupport::TestCase

  def setup
    @patient = patients(:larry)
    @entry = HealthEntry.create(patient: @patient, weight: 165, bodyfat: 12, muscle_mass:100, heartrate: 65)
  end
  ############# Scopes  ###################
  test "It can find all entries that require a response" do
    entries = HealthEntry.pending
    assert entries.count == 1
    assert @entry == entries.first

    physician = physicians(:house)
    response = DosageResponse.create(patient: @patient, physician: physician,
     medicine: "Lorax", dosage: "One a day", health_entry_id: @entry.id)

    assert entries.reload.count == 0
  end

  test "It can find all the new entries of existing patients for a physician" do
    physician = physicians(:house)

    entries = HealthEntry.new_entries_for_physician(physician)
    assert entries.count == 0

    response = DosageResponse.create(patient: @patient, physician: physician,
         medicine: "Lorax", dosage: "One a day", health_entry_id: @entry.id)

    assert entries.reload.count == 0

    new_entry = HealthEntry.create(patient: @patient, weight: 175, bodyfat: 13, muscle_mass:105, heartrate: 75)

    assert_equal 1, entries.reload.count
    assert_equal new_entry, entries.first
  end

##############  Actions  ##################

class MockPhoneService
  attr_accessor :message_sent, :to_number
  def send_message(to_number, message)
    @message_sent = message
    @to_number = to_number
  end
end

class ::HealthEntry
  def phone_service
    @phone_service ||= MockPhoneService.new
  end
end

test "it can respond to the patient with a new dosage" do
  physician = physicians(:house)
  response = DosageResponse.create(patient: @patient, physician: physician,
       medicine: "Lorax", dosage: "One a day", health_entry_id: @entry.id)
  @entry.respond_with_dosage(response)

  service = @entry.phone_service
  assert_not_equal service.message_sent, nil, "there should be a message"
  assert_equal @patient.phone_number, service.to_number, "using the patients phone number"
end

##############  Helpers  ##################

  test "it can access the previous health entry for the user" do
    entry2 = HealthEntry.create(patient: @patient, weight: 185, bodyfat: 13, muscle_mass:110, heartrate: 75)

    assert @entry.previous == nil
    assert entry2.previous == @entry
  end
end
