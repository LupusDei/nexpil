class AddWithingsOauthTokenAndSecretToPatient < ActiveRecord::Migration[5.0]
  def change
    change_table :patients do |t|
      t.string :withings_oauth_token
      t.string :withings_oauth_secret
      t.string :withings_user_id
    end
  end
end
