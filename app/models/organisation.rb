class Organisation < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation_type
  has_many :reservations
  has_many :taken_beds, :through => :reservations, :source => :beds
  #has_many :beds, :source => :organisation_type

  def find_beds(options = {})
    start_date = options[:start_date]
    end_date = options[:end_date]
    single_day = options[:day]
    number_of_beds = options[:beds] || 1

    taken_reservations = reservations.find(:all, :conditions => ["start_date <= ? && end_date >= ?", end_date, start_date])
    organisation_type.beds.find(:all, :conditions => ["beds.id not in (?)", taken_reservations.map(&:bed_id)], :limit => number_of_beds)
  end

end
