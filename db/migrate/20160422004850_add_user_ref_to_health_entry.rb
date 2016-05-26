class AddUserRefToHealthEntry < ActiveRecord::Migration[5.0]
  def change
    add_reference :health_entries, :user, foreign_key: true, indexed: true
  end
end
