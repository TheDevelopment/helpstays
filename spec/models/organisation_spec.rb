require 'spec_helper'

describe Organisation do
  before(:each) do
    @organisation = Factory(:organisation)
    @organisation.user.roles << Role.find_or_create_by_title(:title => "organisation")
    @house = Factory(:house)
    5.times {
      a = @house.beds.create!
      a.organisation_types << OrganisationType.first
    }
  end

  it "should create a new instance given valid attributes" do
    organisation = Factory(:organisation)
  end

  it "should have many beds" do
    @organisation.beds.should be_present
    @organisation.beds.should have(5).records
  end
end
