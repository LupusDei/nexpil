class WithingsSDK::MeasurementGroup

  VALUES = {
        WithingsSDK::Measure::Weight => 1,
        WithingsSDK::Measure::Height => 4,
        WithingsSDK::Measure::FatFreeMass => 5,
        WithingsSDK::Measure::FatRatio => 6,
        WithingsSDK::Measure::FatMassWeight => 8,
        WithingsSDK::Measure::Pulse => 11
      }

  def weight
    w = select_measurement_of_type(VALUES[WithingsSDK::Measure::Weight])
    w != nil ? w.value : nil
  end
  def height
    w = select_measurement_of_type(VALUES[WithingsSDK::Measure::Height])
    w != nil ? w.value  : nil
  end
  def fat_free_mass
    w = select_measurement_of_type(VALUES[WithingsSDK::Measure::FatFreeMass])
    w != nil ? w.value : nil
  end
  def fat_ratio
    w = select_measurement_of_type(VALUES[WithingsSDK::Measure::FatRatio])
    w != nil ? w.value : nil
  end
  def fat_mass_weight
    w = select_measurement_of_type(VALUES[WithingsSDK::Measure::FatMassWeight])
    w != nil ? w.value : nil
  end
  def pulse
    w = select_measurement_of_type(VALUES[WithingsSDK::Measure::Pulse])
    w != nil ? w.value : nil
  end

  def select_measurement_of_type(type)
    measures.select {|m| m.type == type}.first
  end
end
