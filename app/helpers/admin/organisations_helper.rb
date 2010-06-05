module Admin::OrganisationsHelper
  def active_column(record)
    if (record.active)
      "Live - " + link_to("Deactivate", :controller => "admin/organisations", :action => "unpublish", :id => record.id)
    else
      "Disabled - " + link_to("Activate", :controller => "admin/organisations", :action => "publish", :id => record.id)
    end
  end
end
