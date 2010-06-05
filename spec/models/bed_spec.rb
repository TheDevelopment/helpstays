require 'spec_helper'

describe Bed do
  before(:each) do
    @bed = Factory(:bed)
    @organisation = Factory(:organisation)
  end

  it "should create a new instance given valid attributes" do
    bed = Factory(:bed)
  end

  it "should belong to a house" do
    @bed.house.should be_present
  end

  it "should have many reservations" do
    @bed.reservations.create!(:start_date => Time.now, 
                             :end_date => 1.week.since,
                             :organisation => @organisation)
    @bed.reservations.should be_present
  end

  describe "should return unavailable for" do

    it "booking over a taken day" do
      @bed.reservations.create!(:start_date => Time.now, :end_date => Time.now, :organisation => @organisation)
      @bed.free?({:start_date => 1.day.ago, :end_date => 1.day.since}).should be_false
    end

    it "booking a day over a taken week" do
      @bed.reservations.create!(:start_date => 1.week.ago, :end_date => 1.week.since, :organisation => @organisation)
      @bed.free?({:start_date => 1.day.ago, :end_date => 1.day.since}).should be_false
    end
  end
end
