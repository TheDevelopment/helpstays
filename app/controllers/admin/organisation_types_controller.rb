class Admin::OrganisationTypesController < AdminController
  access_rule "admin"
  active_scaffold :organisation_types do |config|
    config.columns  = [:name, :organisations]
  end
end
