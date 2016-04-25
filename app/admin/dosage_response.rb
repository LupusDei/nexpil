ActiveAdmin.register DosageResponse do
  menu priority: 4, label: "Dosage Responses"

  permit_params :medicine, :dosage, :user_id, :physician_id

  index do
    selectable_column
    id_column
    column :physician
    column :user
    column :medicine
    column :dosage

    column :created_at
    actions
  end

  filter :physician
  filter :user

  show do |r|
    attributes_table do
      row :id
      row :physician
      row :user
      row :medicine
      row :dosage

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Dosage Response Details" do
      f.input :user
      f.input :physician
      f.input :medicine
      f.input :dosage
    end
    f.actions
  end
end
