ActiveAdmin.register DosageResponse do
  menu priority: 4, label: "Dosage Responses"

  permit_params :medicine, :dosage, :patient_id, :physician_id

  index do
    selectable_column
    id_column
    column :physician
    column :patient
    column :medicine
    column :dosage

    column :created_at
    actions
  end

  filter :physician
  filter :patient

  show do |r|
    attributes_table do
      row :id
      row :physician
      row :patient
      row :medicine
      row :dosage

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Dosage Response Details" do
      f.input :patient
      f.input :physician
      f.input :medicine
      f.input :dosage
    end
    f.actions
  end
end
