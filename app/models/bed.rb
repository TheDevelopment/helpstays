class Bed < ActiveRecord::Base
  belongs_to :house
  has_many :reservations
  has_many :organisations, :through => :reservations
  has_and_belongs_to_many :organisation_types

  validates_presence_of :house_id

  def free?(options = {})
    start_date = options[:start_date]
    end_date = options[:end_date]
    single_day = options[:day]
    return false unless ((start_date && end_date) || single_day)

    results = reservations.find(:all, 
                      :conditions => ["start_date <= ? && end_date >= ?", end_date, start_date])
    return results.blank?

  end

  def taken?(options = {})
    !free(options)
  end
end
