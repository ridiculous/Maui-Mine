class ResourcesController < ApplicationController

  before_filter :set_tags, except: [:index, :show, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
    @resource = Resource.new
    @location = @resource.build_location

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.json
  def create
    resource_params = params[:resource]
    location_params = resource_params[:location]

    @resource = Resource.new
    @resource.name = resource_params[:name]
    @resource.url = resource_params[:url]
    @resource.tag_list = resource_params[:tag_list]
    @resource.use_coordinates = resource_params[:use_coordinates]

    @location = Location.find_or_initialize_by_address_and_region_id(location_params[:address], location_params[:region_id])
    @location.zip = @location.region.zip
    @location.state = 'HI'

    if @resource.use_coordinates
      @location.latitude = location_params[:latitude]
      @location.longitude = location_params[:longitude]
    end

    @resource.location = @location

    respond_to do |format|
      if @resource.save
        format.html { redirect_to resources_path, notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: @resource }
      else
        request.flash[:alert] = 'Try again, minus the errors'
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end

  private

  def set_tags
    @tags ||= ActsAsTaggableOn::Tag.all.map { |t| t.name.titleize }
  end
end
