ActiveAdmin.register User, namespace: Physician do
  menu priority: 1, label: "Patients"
  config.comments = false
  index do
      selectable_column
      id_column
      column :first_name
      column :last_name
      column :email
      column :age
      column :gender
      column :comorbid_conditions

      column :created_at
      actions
    end

end
