ActiveAdmin.register Patient do
  menu priority: 1, label: "Patients"
  permit_params :first_name, :last_name, :email,
               :age, :gender, :medical_history, :phone_number,
               :withings_user_id, :withings_oauth_secret, :withings_oauth_token,

  perscriptions_attributes: [:id, :medicine, :dosage, :patient_id, :_destroy],
  health_entries_attributes: [:id, :weight, :bodyfat, :muscle_mass, :heartrate, :patient_id, :_destroy]
  config.comments = false

  controller do
    def withings_client(options = {})
      WithingsSDK::Client.new({consumer_key: Rails.application.secrets.withings_api_key,
             consumer_secret: Rails.application.secrets.withings_api_secret}.merge(options))
    end
  end

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

    actions
  end

  show title: proc {|p| p.to_s} do |patient|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :age
      row :gender
      row :medical_history
      row 'Withings' do |patient|
        if patient.withings_user_id != nil && patient.withings_user_id != ""
          text_node "Connected!"
        else
          text_node link_to("Connect to Withings", link_to_withings_admin_patient_path(patient))
        end
      end

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
      text_node link_to "Refresh Entries", refresh_withings_entries_admin_patient_path(patient)
      table_for(patient.health_entries.limit(10)) do
        column("Date Added") {|e| e.created_at}
        column("Date Recorded") {|e| e.recorded_at}
        column("Weight") {|e| e.display_weight}
        column("Body Fat %") {|e| e.bodyfat}
        column("Non Fat Mass") {|e| e.display_muscle_mass}
        column("Heart Rate") {|e| e.heartrate}
        column("Withings Key") {|e| e.foreign_key}
      end
    end
  end

  form title: proc {|p| p.first_name? ? p.to_s : "New Patient"} do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :age
      f.input :gender
      f.input :medical_history
      f.input :withings_user_id
      f.input :withings_oauth_token
      f.input :withings_oauth_secret
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


  member_action :link_to_withings, method: :get do
    patient = Patient.find(params[:id])
    client = withings_client()
    request_token = client.request_token({oauth_callback: withings_connect_admin_patient_url(patient)})
    auth_url = client.authorize_url(request_token.token, request_token.secret)
    patient.withings_oauth_token = request_token.token
    patient.withings_oauth_secret = request_token.secret
    patient.save
    redirect_to auth_url
  end
  member_action :withings_connect, method: :get do
    patient = Patient.find(params[:id])
    patient.withings_user_id = params[:userid]
    client = withings_client()
    access_token = client.access_token(patient.withings_oauth_token, patient.withings_oauth_secret, {oauth_verifier: params[:oauth_verifier]})
    patient.withings_oauth_token = access_token.token
    patient.withings_oauth_secret = access_token.secret
    patient.save
    redirect_to admin_patient_path(patient), {notice: "Successfully Linked to Withings"}
  end

  member_action :refresh_withings_entries, method: :get do
    patient = Patient.find(params[:id])
    client = withings_client({token: patient.withings_oauth_token, secret:patient.withings_oauth_secret})
    start_date = patient.most_recent_health_entry.try(:recorded_at) || 1.year.ago
    end_date = DateTime.now
    measures = client.body_measurements(patient.withings_user_id, {startdate: start_date, enddate: end_date })

    grouped = measures.group_by {|group_measurement| group_measurement.date}
    ## doing this because Pulse comes separate from other measurments

    grouped.values.each do |group_array|
      he = patient.health_entries.new
      group_array.each do |group| #shouldnt overright data because each group only has select info
        he.weight ||= group.weight
        he.bodyfat ||= group.fat_ratio
        he.muscle_mass ||= group.fat_free_mass
        he.heartrate ||= group.pulse
        he.recorded_at ||= Time.at(group.date).to_datetime
        he.foreign_key ||= group.grpid
        puts "Entry for group #{group.grpid} weight:#{group.weight} bf: #{group.fat_ratio} mm: #{group.fat_free_mass}"
      end
      he.save
    end
    redirect_to admin_patient_path(patient), {notice: "Updated Health Enties from Withings"}
  end
end
