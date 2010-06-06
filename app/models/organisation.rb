class Organisation < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation_type
  has_many :reservations
  has_many :taken_beds, :through => :reservations, :source => :bed

  def beds
    organisation_type.beds
  end

  def find_beds(options = {})
    start_date = options[:start_date] || Date.today
    end_date = options[:end_date] || Date.today
    single_day = options[:day]
    number_of_beds = options[:beds] || 1
    lat = options[:latitude]
    long = options[:longitude]
    radius = options[:radius]
    return false unless ((start_date && end_date) || single_day)

    if (start_date && end_date).blank?
      start_date = single_date.to_date
      end_date = single_date.to_date
    end

    if lat && long && radius
      houses_found = House.find(:all, :origin =>[lat, long], :within => radius, :include => :beds)
      beds_found = houses_found.map(&:beds).flatten
      bed_ids_found = beds_found.map(&:id)

      taken_reservations = reservations.find(:all, :conditions => ["start_date <= ? AND end_date >= ? AND bed_id in (?)", end_date, start_date, bed_ids_found])
    else
      taken_reservations = reservations.find(:all, :conditions => ["start_date <= ? AND end_date >= ?", end_date, start_date])
      beds_found = beds
    end

    beds_found - taken_reservations.map(&:bed)
  end

  def reserve_bed(options = {})
    bed_id = options[:bed_id]

    start_date = options[:start_date] || Date.today
    end_date = options[:end_date] || Date.today
    single_day = options[:day]
    return false unless ((start_date && end_date) || single_day)

    if (start_date && end_date).blank?
      start_date = single_date.to_date
      end_date = single_date.to_date
    end

    bed = beds.select{|x| x.id == bed_id.to_i}.first
    reserve_success = bed.reserve({start_date => start_date, :end_date => end_date, :organisation_id => self.id}) if bed

    if reserve_success
      return true
    else
      return false
    end
  end


  def publish
    self.update_attribute(:active, true)
  end

  def unpublish
    self.update_attribute(:active, false)
  end

end
