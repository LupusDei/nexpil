ActiveAdmin.register Patient do
  menu priority: 1, label: "Patients"
  permit_params :first_name, :last_name, :email,
               :age, :gender, :medical_history,

  perscriptions_attributes: [:id, :medicine, :dosage, :patient_id, :_destroy],
  health_entries_attributes: [:id, :weight, :bodyfat, :muscle_mass, :heartrate, :patient_id, :_destroy]
  config.comments = false
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :age
    column :gender
    column :medical_history

    column :created_at

    actions
  end

  show title: proc {|p| p.to_s} do |patient|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :age
      row :gender
      row :medical_history

      row :created_at
      row :updated_at
    end

    panel "Prescriptions" do
      table_for(patient.perscriptions) do
        column("Medicine") {|p| p.medicine}
        column("Dosage") {|p| p.dosage}
      end
    end

    panel "Health Entries" do
      table_for(patient.health_entries) do
        column("Date Added") {|e| e.created_at}
        column("Weight") {|e| e.weight}
        column("Body Fat") {|e| e.bodyfat}
        column("Muscle Mass") {|e| e.muscle_mass}
        column("Heart Rate") {|e| e.heartrate}
      end
    end
  end

  form title: proc {|p| p.first_name? ? p.to_s : "New Patient"} do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :age
      f.input :gender
      f.input :medical_history
    end

    f.inputs "Prescriptions" do
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
