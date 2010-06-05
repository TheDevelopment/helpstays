require 'spec_helper'

describe Reservation do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Reservation.create!(@valid_attributes)
  end
end
