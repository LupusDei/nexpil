ActiveAdmin.register DosageResponse, namespace: :portal do
  menu priority: 1, label: "Dosage Responses"

  config.comments = false


  permit_params :medicine, :dosage, :patient_id, :physician_id

  controller do
    def scoped_collection
      DosageResponse.where(physician_id: current_physician.id)
    end
  end

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
