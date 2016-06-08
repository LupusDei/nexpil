ActiveAdmin.register Physician do
  menu priority: 3, label: "Physicians"
  permit_params :first_name, :last_name, :email, :phone,
                :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone
    column :last_sign_in_at

    column :created_at
    actions
  end

  show do |phys|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone
      row :last_sign_in_at
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Physician Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
