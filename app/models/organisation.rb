class Organisation < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation_type
  has_and_belongs_to_many :reservations
end
