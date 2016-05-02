ActiveAdmin.register Patient do
  menu priority: 1, label: "Patients"
  permit_params :first_name, :last_name, :email,
               :age, :gender, :medical_history
  config.comments = false
  index do
      selectable_column
      id_column
      column :first_name
      column :last_name
      column :email
      column :age
      column :gender
      column :medical_history

      column :created_at

      column current_physician.first_name
      actions
    end

end
