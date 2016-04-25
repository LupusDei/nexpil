ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
        column do
            panel "New Users" do
                ul do
                    User.last(5).map do |user|
                        li link_to(user.to_s, admin_user_path(user))
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
                        entry_label = "#{e.user}: W:#{e.weight} BF:#{e.bodyfat} MM:#{e.muscle_mass} HR:#{e.heartrate}"
                        li link_to(entry_label, admin_user_path(e.user))
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
