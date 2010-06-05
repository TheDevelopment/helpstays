require 'spec_helper'

describe Api::V1::BedsController do
  include CrudSetup

  before(:each) do
    @model = 'Bed'
    setup_crud_names
    setup_auth
  end

  describe "CRUD testing" do

    it_should_behave_like "CRUD GET index"
    #it_should_behave_like "CRUD GET show"
    #it_should_behave_like "CRUD POST create"
    #it_should_behave_like "CRUD PUT update"
    #it_should_behave_like "CRUD GET edit"
    #it_should_behave_like "CRUD DELETE destroy"
  end
end

