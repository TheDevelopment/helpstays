require 'spec_helper'

describe Reservation do
  before(:each) do
    @bed = Factory(:bed)
    @bed.organisation_types << Factory(:organisation_type)
    @organisation = Factory(:organisation)
    @reservation = @bed.reservations.create!(:start_date => Time.now,
                                             :end_date => Time.now,
                                             :organisation => @organisation)
  end

  it "should create a new instance given valid attributes" do
    reservation = Factory(:reservation)
  end

  it "should return no available beds when all the beds are taken" do
    @organisation.find_beds({:start_date => 1.day.ago,
                              :end_date => 1.day.since,
                              :number_of_beds => 1}).should have(0).records
  end

  it "should return available beds for a day" do
    5.times {
      a = @bed.house.beds.create!()
      a.organisation_types << OrganisationType.first
    }
    @bed.house.beds.should have(6).records
    @organisation.find_beds({:start_date => 1.day.ago,
                              :end_date => 1.day.since,
                              :number_of_beds => 1}).should have(5).records
  end
end
