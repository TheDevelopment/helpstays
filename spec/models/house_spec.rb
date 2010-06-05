require 'spec_helper'

describe House do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    house = Factory(:house)
  end

  it "should have many beds" do
    house = Factory(:house)
    5.times {house.beds.create!()}
    house.beds.should have(5).records
  end

  it "should have one owner" do
    house = Factory(:house)
    house.user.should be_present
  end

  it "should have a geocodable address" do
    house = Factory(:house)
    house.geocode_address.should be_true 
    # should have lat/long after geocoding
    house.lat.should  == -35.344187
    house.long.should == 149.141668        
  end
  
  it "should find house within the correct range" do
    house = Factory(:house)
    house.geocode_address
    houses_found = House.find(:all, :origin =>[house.lat,house.long], :within=>10)
    houses_found.first.should == house
  end

  it "should not find house outside the range" do
    house = Factory(:house)
    house.geocode_address
    houses_found = House.find(:all, :origin =>[house.lat+10,house.long+10], :within=>10)
    houses_found.should be_empty
  end

end
