class Physician < ApplicationRecord


  def to_s
    "Dr. #{self.first_name} #{self.last_name}"
  end
end
