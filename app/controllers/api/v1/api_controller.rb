class Api::V1::ApiController < ApplicationController
  skip_before_filter :login_required
  #before_filter :authentication_required
  #before_filter :check_permissions

  # GET /products.json
  # GET /products.xml
  def index
    @klass_results = @klass.find(:all)

    respond_to do |format|
      format.xml  {render :xml   => @klass_results}
      format.json {render :json  => @klass_results}
    end
  end

  # GET /products/1.xml
  # GET /products/1.json
  def show
    @klass_results = @klass.find(params[:id])
    @current_user

  rescue ActiveRecord::RecordNotFound
    render :nothing => true, :status => :not_found
  end

  # GET /products/new.xml
  # GET /products/new.json
  def new
    @klass_results = @klass.new
    respond_to do |format|
      format.xml  {render :xml  => @klass_results}
      format.json {render :json => @klass_results}
    end
  end

  # GET /products/1/edit
  def edit
    @klass_results = @klass.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :nothing => true, :status => :not_found
  end

  # POST /products.xml
  # POST /products.json
  def create
    @klass_results = @klass.new(params[@klass.to_s.underscore.to_sym])

    respond_to do |format|

      if @klass_results.save
        format.xml  {render :xml  => @klass_results, :status => :created}
        format.json {render :json => @klass_results, :status => :created}
      else
        format.xml  {render :xml  => @klass_results.errors, :status => :unprocessable_entity}
        format.json {render :json => @klass_results.errors, :status => :unprocessable_entity}
      end
    end
  rescue ActiveRecord::UnknownAttributeError
    render :nothing => true, :status => :not_acceptable
  end

  # PUT /products/1.xml
  # PUT /products/1.json
  def update
    @klass_results = @klass.find(params[:id])
    respond_to do |format|
      if @klass_results.update_attributes(params[@klass.to_s.underscore.to_sym])
        format.xml  {head :ok}
        format.json {head :ok}
      else
        format.xml  {render :xml  => @klass_results.errors, :status => :unprocessable_entity}
        format.json {render :json => @klass_results.errors, :status => :unprocessable_entity}
      end
    end

  rescue ActiveRecord::RecordNotFound
    render :nothing => true, :status => :not_found
  end

  # DELETE /products/1.xml
  # DELETE /products/1.json
  def destroy
    @klass_results = @klass.find(params[:id])
    @klass_results.destroy
    respond_to do |format|
      format.xml {head :ok}
      format.json {head :ok}
    end
  rescue ActiveRecord::RecordNotFound
    render :nothing => true, :status => :not_found
  end

  protected
  def write_actions
    %w(edit create update new destroy)
  end

  def forbiden_actions
    []
  end

  def check_permissions
     block_and_return_403 if forbiden_actions.include?(action_name)
  end

  def block_and_return_403
    render :nothing => true, :status => :forbidden
  end

  def self.define_restful_class(klass, options = {})
    before_filter(options) do |controller|
      controller.send(:set_controller_class, klass)
    end
  end

  def set_controller_class(klass)
    @klass = @current_user.organisations.first.send(klass.to_s.downcase.pluralize.to_sym)
  end

  def self.authenticate(role, options = {})
    before_filter(options) do |controller|
      controller.send(:authenticate_with_role, role)
    end
  end

  def authenticate_with_role(role)
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.authenticate(username, password)
      @organisation = @current_user.organisations.first
      has_permission?(role, @current_user)
    end
  end
end

