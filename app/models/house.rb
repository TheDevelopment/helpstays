include Geokit::Geocoders
class House < ActiveRecord::Base
  belongs_to :user
  has_many :beds
  has_many :organisation_types, :through => :beds
  
  def full_address
    [self.address_1, self.address_2, self.suburb, self.state, self.post_code, self.country].join(", ") 
  end
  
  def geocode_address
    a = MultiGeocoder.geocode(self.full_address)
    if a.success
      self.lat = a.lat; self.long = a.lng
      return true
    else
      return false
    end
  end
end
