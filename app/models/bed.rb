class Bed < ActiveRecord::Base
  belongs_to :house
  has_many :reservations
  has_many :organisations, :through => :reservations
  has_many :beds_for_organisations
  has_many :organisation_types, :through => :beds_for_organisations

  validates_presence_of :house_id

  def free?(options = {})
    start_date = options[:start_date]
    end_date = options[:end_date]
    single_day = options[:day]
    return false unless ((start_date && end_date) || single_day)

    if (start_date && end_date).blank?
      start_date = single_date
      end_date = single_date 
    end

    results = reservations.find(:all, 
                      :conditions => ["start_date <= ? AND end_date >= ?", end_date, start_date])
    return results.blank?

  end

  def taken?(options = {})
    !free(options)
  end
end
