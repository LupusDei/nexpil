ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :age,
    :gender, :comorbid_conditions, :medicines, :doses

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :age
    column :gender
    column :comorbid_conditions
    column :medicines
    column :doses

    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :age
      f.input :gender
      f.input :comorbid_conditions
      f.input :medicines
      f.input :doses
    end
    f.actions
  end

end
