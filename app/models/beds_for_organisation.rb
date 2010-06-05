class BedsForOrganisation < ActiveRecord::Base
  belongs_to :bed
  belongs_to :organisation_type
end
