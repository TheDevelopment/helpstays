require 'spec_helper'

describe Bed do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Bed.create!(@valid_attributes)
  end
end
