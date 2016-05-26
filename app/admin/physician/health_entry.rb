ActiveAdmin.register HealthEntry, namespace: :portal do
  menu priority: 1, label: "Tasks"

  scope("Awaiting Your Response", default: true) {|scope| scope.new_entries_for_physician(current_physician) }
  scope("All Pending Entries") {|scope| scope.pending }

  config.comments = false

  actions :all, :except => [:new, :edit, :create, :destroy]

  permit_params :dosage, :medicine, :dosage_response, :id, dosage_response_attributes: [:dosage, :medicine]

  controller do
    def scoped_collection˜
      HealthEntry.includes(:patient)
    end
  end

  index title: "Patient Health Entries" do
    selectable_column
    column 'Patient' do |entry|
      text_node link_to(entry.patient.to_s, portal_patient_path(entry.patient))
    end

    column :weight
    column :bodyfat
    column :muscle_mass
    column :heartrate

    column :created_at

    column '' do |entry|
      text_node link_to("Respond", portal_health_entry_path(entry))
    end
  end

  show do |entry|
    attributes_table do
      row :patient
      row :dosage_response

      if entry.previous.nil?
        row :weight
        row :bodyfat
        row :muscle_mass
        row :heartrate
        row :created_at
      else
        row("Weight") do
          text_node entry.weight
          p "  <-  (#{entry.previous.weight})"
        end
        row("Body Fat") do
          text_node entry.bodyfat
          p "  <-  (#{entry.previous.bodyfat})"
        end
        row("Muscle Mass") do
          text_node entry.muscle_mass
          p "  <-  (#{entry.previous.muscle_mass})"
        end
        row("Heart Rate") do
          text_node entry.heartrate
          p "  <-  (#{entry.previous.heartrate})"
        end

        row("Created At") do
          text_node entry.created_at
          p " __ (#{distance_of_time_in_words(entry.previous.created_at, entry.created_at)} since last entry)"
        end

        row("Previous Response") do
          auto_link entry.previous.dosage_response
        end
      end
    end
    panel "Respond with new Dosage" do
      dr = DosageResponse.new(physician: current_physician)
      form_for dr, url: respond_portal_health_entry_path(), method: :post do |f|
        f.label "Dosage:", style: "padding-right: 10px"
        f.text_field :dosage, style: "width: 200px"
        div
        f.label "Medicine:", style: "padding-right: 10px"
        f.text_field :medicine, value: entry.previous.nil? ? "" : entry.previous.dosage_response.try(:medicine),
          style: "width: 200px"
        div
        f.input value: "Respond", type: :submit, style: "padding-top: 10px"

      end
    end
  end

  member_action :respond, method: :post do
    entry = HealthEntry.find(params[:id])
    dr_params = params[:dosage_response].permit(:medicine, :dosage)
    dr = DosageResponse.create(dr_params.merge(physician_id: current_physician.id, patient_id: entry.patient_id))
    entry.dosage_response = dr
    entry.save
    redirect_to(portal_health_entry_path(entry), {notice: "Responded with new dosage!"})
  end

end
