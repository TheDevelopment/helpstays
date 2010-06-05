class Reservation < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :bed

  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :organisation_id
  validates_presence_of :bed_id
end
