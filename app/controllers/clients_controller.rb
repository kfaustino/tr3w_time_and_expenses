class ClientsController < ApplicationController
  respond_to :html, :xml, :json
  # GET /clients
  # GET /clients.xml
  # GET /clients.json
  def index
    @clients = Client.where(params.except(:action, :controller, :format)).to_a # TODO: remove .to_a when Rails to_json bug fixed
    respond_with(@clients)
  end

  def draft_timesheets_count
    @clients = Client.all
    @timesheets = @clients.map do |client|
      { :id => client.id, :draft_timesheets_count => client.draft_timesheets.count }
    end
    respond_with(@timesheets)
  end

  def recent
    @clients = Client.recent.to_a # TODO: remove .to_a when Rails to_json bug fixed
    respond_with(@clients)
  end

  # GET /clients/newest
  # GET /clients/newest.xml
  # GET /clients/newest.json
  def newest
    @client = Client.recent.first
    respond_with(@client)
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])
    respond_with(@client)
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1;edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])
    flash[:notice] = 'Client was successfully created.' if @client.save
    respond_with(@client)
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])
    flash[:notice] = 'Client was successfully updated.' if @client.update_attributes(params[:client])
    respond_with(@client)
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    respond_with(@client)
  end
end
