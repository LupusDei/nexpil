ActiveAdmin.register Perscription do
  belongs_to :patient
  permit_params :medicine, :dosage, :patient

  index do
    selectable_column
    id_column
    column :medicine
    column :dosage
    column :patient

    column :created_at
    actions
  end

  filter :patient
  filter :created_at

  form do |f|
    f.inputs "Perscription" do
      f.input :medicine
      f.input :dosage
      f.input :patient  #this will explode eventually when there are hundreds/thousands of patients

    end
    f.actions
  end
end
