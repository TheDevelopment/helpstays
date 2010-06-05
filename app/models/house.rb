class House < ActiveRecord::Base
  belongs_to :user
  has_many :beds
  has_many :organisation_types, :through => :beds
end
