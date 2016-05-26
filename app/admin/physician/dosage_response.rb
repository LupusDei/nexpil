ActiveAdmin.register DosageResponse, namespace: :portal do
  menu priority: 2, label: "Dosage Updates"

  config.comments = false

  actions :all, :except => [:new, :destroy]
  permit_params :medicine, :dosage, :patient_id, :physician_id

  controller do
    def scoped_collection
      DosageResponse.where(physician_id: current_physician.id)
    end
  end

  index title: "Dosage Updates" do
    selectable_column
    id_column
    column '' do |patient|
      text_node link_to(patient.to_s, portal_patient_path(patient))
    end
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
