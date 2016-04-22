class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.string :gender
      t.text :comorbid_conditions
      t.text :medicines
      t.text :doses

      t.timestamps  null: false
    end
  end
end
