class AddPhoneNumberToPatient < ActiveRecord::Migration[5.0]
  def change
    change_table :patients do |t|
      t.string :phone_number
    end
  end
end
