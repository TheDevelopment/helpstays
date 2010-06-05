class Admin::OrganisationsController < AdminController
  access_rule "admin"
  active_scaffold :organisation do |config|
    config.actions.exclude :nested
    config.columns  = [:name, :active, :user]
  end
  
 def publish
   organisation = Organisation.find(params['id'])
   organisation.publish
   redirect_to :controller => "organisations", :action => :list
 end

 def unpublish
   organisation = Organisation.find(params['id'])
   organisation.unpublish
   redirect_to :controller => "organisations", :action => :list
 end
  
end
