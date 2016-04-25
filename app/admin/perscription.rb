ActiveAdmin.register Perscription do
  belongs_to :user
  permit_params :medicine, :dosage, :user

  index do
    selectable_column
    id_column
    column :medicine
    column :dosage
    column :user

    column :created_at
    actions
  end

  filter :user
  filter :created_at

  form do |f|
    f.inputs "Perscription" do
      f.input :medicine
      f.input :dosage
      f.input :user  #this will explode eventually when there are hundreds/thousands of users

    end
    f.actions
  end
end
