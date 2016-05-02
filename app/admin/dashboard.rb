ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
        column do
            panel "New Patients" do
                ul do
                    Patient.last(5).map do |patient|
                        li link_to(patient.to_s, admin_patient_path(patient))
                    end
                end
            end
        end
        column do
            panel "New Physicians" do
                ul do
                    Physician.last(5).map do |phys|
                        li link_to(phys.to_s, admin_physician_path(phys))
                    end
                end
            end
        end
    end

    columns do
        column do
            panel "Recent Health Entries" do
                ul do
                    HealthEntry.last(10).map do |e|
                        entry_label = "#{e.patient}: W: #{e.weight} BF: #{e.bodyfat} MM: #{e.muscle_mass} HR: #{e.heartrate}"
                        li link_to(entry_label, admin_patient_path(e.patient))
                    end
                end
            end
        end
    end

    columns do
        column do
            panel "Recent Dosage Responses" do
                ul do
                    DosageResponse.last(10).map do |r|
                        li link_to(r, admin_dosage_response_path(r))

                    end
                end
            end
        end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
