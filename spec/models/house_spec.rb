require 'spec_helper'

describe House do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    House.create!(@valid_attributes)
  end
end
