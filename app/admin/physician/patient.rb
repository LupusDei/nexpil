ActiveAdmin.register Patient, namespace: :portal do
  menu priority: 3, label: "Patients"

  config.comments = false

  actions :all, :except => [:new, :create, :edit, :destroy]

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :age
    column :gender
    column :medical_history

    column :created_at
    column '' do |patient|
      text_node link_to('View', portal_patient_path(patient), class: 'member_link view_link')
    end
  end

  show title: proc {|p| p.to_s} do |patient|
    panel "Health Entries" do
      table_for(patient.health_entries.limit(10)) do
        column("Date Recorded") {|e| e.recorded_at}
        column("Weight") {|e| e.display_weight}
        column("Body Fat %") {|e| e.bodyfat}
        column("Non Fat Mass") {|e| e.display_muscle_mass}
        column("Heart Rate") {|e| e.heartrate}
      end
    end
    panel "Recommended Dosages" do
      table_for(patient.dosage_responses.limit(5)) do
        column("Physician") {|e| e.physician}
        column("Medicine") {|e| e.medicine}
        column("Dosage") {|e| e.dosage}
        column("Date") {|e| e.created_at }
      end
    end

    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
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
  end

end
