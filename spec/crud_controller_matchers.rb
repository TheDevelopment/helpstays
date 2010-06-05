module CrudSetup
  def setup_crud_names
    # set up the variables we'll refer to in all specs below.
    @model_name                    = @model.classify
    @model_klass                   = @model_name.constantize
    @model_symbol                  = @model_name.to_sym
    @pluralized_model_name         = @model_name.humanize.pluralize
    @assigns_model_name            = @model_name.underscore.to_sym
    @pluralized_assigns_model_name = @model_name.underscore.pluralize.to_sym

    @stubbed_model = mock(@model_name,
                                    :id => 1,
                                    :to_json => "JSON",
                                    :to_xml => 'XML',
                                    :mock_object => true,
                                    :load => true,
                                    :update_attributes => true,
                                    :errors => "Error")
  end

  def setup_auth
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Basic.encode_credentials("admin", 'secret')
  end

  def truncate_crud_tables
    Product.find(:all).collect{|x| Product.delete(x.id) if x && x.id}
    Channel.find(:all).collect{|x| Channel.delete(x.id) if x && x.id}
    Event.find(:all).collect{|x| Event.delete(x.id) if x && x.id}
    Keyword.find(:all).collect{|x| Keyword.delete(x.id) if x && x.id}
  end
end

describe "CRUD GET index", :shared => true do
  before(:each) do
    @model_klass.stub!(:find).and_return([@stubbed_model])
  end

  it "should find all #{@pluralized_model_name}" do
    @model_klass.should_receive(:find).with(:all).and_return([@stubbed_model])
    do_get
  end

  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should be successful with json" do
    do_get 'json'
    response.should be_success
  end

  def do_get format = 'xml'
    get 'index', :format => format
  end
end

describe "CRUD GET show", :shared => true do

  describe "with a valid ID" do
    before(:each) do
      @model_klass.stub!(:find).and_return(@stubbed_model)
    end

    it "should find the correct #{@model_name}" do
      @model_klass.should_receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_get
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should be successful with json" do
      do_get "json"
      response.should be_success
    end

    def do_get format = 'xml'
      get 'show', :id => @stubbed_model.id, :format => format
    end
  end

  describe "with an invalid ID" do
    before(:each) do
      @model_klass.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end

    it "should send a 404 if not found via XML" do
      do_get 'xml'
      response.status.should == "404 Not Found"
    end

    it "should send a 404 if not found via json" do
      do_get 'json'
      response.status.should == "404 Not Found"
    end

    def do_get(format = 'xml')
      get 'show', :id => -1, :format => format
    end
  end
end

describe "CRUD POST create", :shared => true do

  describe "with valid params" do

    before(:each) do
      @new_stubbed_model = Factory.new(@assigns_model_name)
      @model_klass.stub!(:new).and_return(@new_stubbed_model)

      @params = {"title" => 'test', "key" => "value"}
    end

    it "should build a new #{@model_name}" do
      @model_klass.should_receive(:new).with(@params).and_return(@new_stubbed_model)
      do_post
    end

    it "should save the #{@model_name}" do
      @new_stubbed_model.should_receive(:save).and_return(true)
      do_post
    end

    it "should be a success with xml" do
      do_post
      response.should be_success
    end

    it "should be a success with json" do
      do_post 'json'
      response.should be_success
    end

    def do_post(format = 'xml')
      post 'create', @assigns_model_name => @params, :format => format
    end
  end

  describe "with invalid parameters" do
    before(:each) do
      @model_klass.stub!(:new).and_return(@stubbed_model)
      @stubbed_model.stub!(:save).and_return(false)
    end

    it "should render the error page in xml" do
      do_post
      response.status.should == "422 Unprocessable Entity"
    end

    it "should render the the error page in json" do
      do_post "json"
      response.status.should == "422 Unprocessable Entity"
    end

    def do_post(format = 'xml')
      post 'create', @assigns_model_name => {:code => "aasdasd"}, :format => format
    end
  end
end

describe "CRUD PUT update", :shared => true do

  describe "with valid parameters" do

    before(:each) do
      @model_klass.stub!(:find).and_return(@stubbed_model)
      @stubbed_model.stub!(:save).and_return(true)
    end

    it "should find the #{@model_name}" do
      @model_klass.should_receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_put
    end

    it "should render 200 OK for json" do
      do_put 'json'
      response.status.should == "200 OK"
    end

    it "should render 200 OK for XML" do
      do_put 'xml'
      response.status.should == "200 OK"
    end

    def do_put format = 'xml'
      put 'update', :id => @stubbed_model.id, @assigns_model_name => {:code => 'test'}, :format => format
    end
  end

  describe "with invalid parameters" do
    before(:each) do
      @model_klass.stub!(:find).and_return(@stubbed_model)
      @stubbed_model.stub!(:save).and_return(false)
      @stubbed_model.stub!(:update_attributes).and_return(false)
    end

    it "should render the error page in xml" do
      do_put
      response.status.should == "422 Unprocessable Entity"
    end

    it "should render the the error page in json" do
      do_put "json"
      response.status.should == "422 Unprocessable Entity"
    end


    def do_put(format = 'xml')
      put 'update', :id => @stubbed_model.id, @assigns_model_name => {:code => nil}, :format => format
    end
  end

  describe "with an invalid ID" do

    before(:each) do
      @model_klass.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end

    it "should render a 404 when requesting json" do
      do_put 'json'
      response.status.should == "404 Not Found"
    end

    it "should render a 404 when requesting XML" do
      do_put 'xml'
      response.status.should == "404 Not Found"
    end

    def do_put format = 'xml'
      put 'update', :id => @stubbed_model.id, @assigns_model_name => {}, :format => format
    end
  end
  
end

describe "CRUD DELETE destroy", :shared => true do

  describe "with a valid id" do

    before(:each) do
      @model_klass.stub!(:find).and_return(@stubbed_model)
      @stubbed_model.stub!(:destroy).and_return(true)
    end

    it "should find the correct #{@model_name}" do
      @model_klass.should_receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_delete
    end

    it "should destroy the #{@model_name}" do
      @stubbed_model.should_receive(:destroy).and_return(true)    
      do_delete
    end

    it "should render 200 when requesting json" do
      do_delete 'json'
      response.status.should == "200 OK"
    end

    it "should render 200 when requesting XML" do
      do_delete 'xml'
      response.status.should == "200 OK"
    end

    def do_delete format = 'xml'
      delete 'destroy', :id => @stubbed_model.id, :format => format
    end
  end

  describe "with an invalid ID" do

    before(:each) do
      @model_klass.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end

    it "should render a 404 when requesting json" do
      do_delete 'json'
      response.status.should == "404 Not Found"
    end

    it "should render a 404 when requesting XML" do
      do_delete 'xml'
      response.status.should == "404 Not Found"
    end

    def do_delete format = 'xml'
      delete 'destroy', :id => -1, :format => format
    end
  end
end

describe "CRUD GET edit", :shared => true do

  describe "with a valid ID" do
    before(:each) do
      @model_klass.stub!(:find).and_return(@stubbed_model)
    end

    it "should find the #{@model_name}" do
      @model_klass.should_receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_get
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should be successful" do
      do_get "json"
      response.should be_success
    end

    def do_get format = 'xml'
      get 'edit', :id => @stubbed_model.id, :format => format
    end
  end

  describe "with an invalid ID" do
    before(:each) do
      @model_klass.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end

    it "should render a 404 when requesting json" do
      do_get 'json'
      response.status.should == "404 Not Found"
    end

    it "should render a 404 when requesting xml" do
      do_get 'xml'
      response.status.should == "404 Not Found"
    end

    def do_get format = 'xml'
      get 'edit', :id => -1, :format => format
    end
  end
end

