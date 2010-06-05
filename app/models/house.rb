include Geokit::Geocoders
class House < ActiveRecord::Base

  before_save :geocode_address

  acts_as_mappable :default_units => :km, 
    :default_formula => :sphere, 
    :lat_column_name => :lat,
    :lng_column_name => :long

  belongs_to :user
  has_many :beds
  has_many :organisation_types, :through => :beds

  validates_presence_of :user_id

  def defined_address
    [self.address_1, self.address_2, self.suburb, self.state, self.post_code, self.country].join(", ") 
  end

  def geocode_address
    a = MultiGeocoder.geocode(self.defined_address)
    if a.success
      self.lat = a.lat; self.long = a.lng
      return true
    else
      return false
    end
  end
end
