class OrganisationType < ActiveRecord::Base
  has_many :organisations
  has_many :beds_for_organisation
  has_many :beds, :through => :beds_for_organisation
end
