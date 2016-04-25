ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :age,
    :gender, :comorbid_conditions,
     perscriptions_attributes: [:id, :medicine, :dosage, :user_id, :_destroy],
     health_entries_attributes: [:id, :weight, :bodyfat, :muscle_mass, :heartrate, :user_id, :_destroy]

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
  show do |user|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :age
      row :gender
      row :comorbid_conditions
      row :created_at
      row :updated_at

    end

    panel "Perscriptions" do
      table_for(user.perscriptions) do
        column("Medicine") {|p| p.medicine}
        column("Dosage") {|p| p.dosage}
      end
    end

    panel "Health Entries" do
      table_for(user.health_entries) do
        column("Date Added") {|e| e.created_at}
        column("Weight") {|e| e.weight}
        column("Body Fat") {|e| e.bodyfat}
        column("Muscle Mass") {|e| e.muscle_mass}
        column("Heart Rate") {|e| e.heartrate}
      end
    end
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
    end

    f.inputs "Perscriptions" do
      f.has_many :perscriptions, heading: false, allow_destroy: true do |p|
        p.input :medicine
        p.input :dosage
      end
    end

    f.inputs "Health Entries" do
      f.has_many :health_entries, heading: false, allow_destroy: true do |e|
        e.label :created_at
        e.input :weight
        e.input :bodyfat
        e.input :muscle_mass
        e.input :heartrate
      end
    end
    f.actions
  end

end
