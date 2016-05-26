require 'test_helper'

class HealthEntryTest < ActiveSupport::TestCase

  ############# Scopes  ###################
  test "It can find all entries that require a response" do
    patient = patients(:larry)
    entry = HealthEntry.create(patient: patient, weight: 165, bodyfat: 12, muscle_mass:100, heartrate: 65)

    entries = HealthEntry.pending
    assert entries.count == 1
    assert entry == entries.first

    physician = physicians(:house)
    response = DosageResponse.create(patient: patient, physician: physician, medicine: "Lorax", dosage: "One a day")
    entry.dosage_response = response
    entry.save

    assert entries.reload.count == 0
  end

  test "It can find all the new entries of existing patients for a physician" do
    patient = patients(:larry)
    physician = physicians(:house)
    entry = HealthEntry.create(patient: patient, weight: 165, bodyfat: 12, muscle_mass:100, heartrate: 65)

    entries = HealthEntry.new_entries_for_physician(physician)
    assert entries.count == 0

    response = DosageResponse.create(patient: patient, physician: physician, medicine: "Lorax", dosage: "One a day")
    entry.dosage_response = response
    entry.save

    assert entries.reload.count == 0

    new_entry = HealthEntry.create(patient: patient, weight: 175, bodyfat: 13, muscle_mass:105, heartrate: 75)

    assert entries.reload.count == 1
    assert new_entry == entries.first
  end

##############  Helpers  ##################

  test "it can access the previous health entry for the user" do
    patient = patients(:larry)
    entry = HealthEntry.create(patient: patient, weight: 165, bodyfat: 12, muscle_mass:100, heartrate: 65)
    entry2 = HealthEntry.create(patient: patient, weight: 185, bodyfat: 13, muscle_mass:110, heartrate: 75)

    assert entry.previous == nil
    assert entry2.previous == entry
  end
end
