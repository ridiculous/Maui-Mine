class ResourcesController < ApplicationController

  before_filter :set_tags, except: [:index, :show, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.order(:name)

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

  def manage
    @resource = Resource.where(id: params[:id]).first_or_initialize
    @resource.add_coordinates = @resource.location && @resource.location.coords_set?
    @resource.add_location = !(@resource.location || @resource.build_location).new_record?

    if request.post? || request.put?
      r_param = params[:resource]
      l_param = r_param[:location]
      @resource.add_location = r_param[:add_location] != '0'
      @resource.name = r_param[:name]
      @resource.url = r_param[:url]
      @resource.tag_list = r_param[:tag_list]
      @resource.add_coordinates = r_param[:add_coordinates] != '0'

      if @resource.add_location
        @resource.location = Location.find_or_initialize_by_address_and_region_id(l_param[:address], l_param[:region_id])
        @resource.location.zip = @resource.location.region.zip
        @resource.location.state = 'HI'

        if @resource.add_coordinates
          @resource.location.latitude = l_param[:latitude]
          @resource.location.longitude = l_param[:longitude]
        else
          @resource.location.latitude = nil
          @resource.location.longitude = nil
        end

        @resource.location.save!
      else
        @resource.location.try(:destroy) unless Resource.find_all_by_location_id(@resource.location.try(:id))
        @resource.location = nil
      end

      @resource.save!
      redirect_to(resources_path, notice: "#{@resource.name} saved")
    end
  rescue
    request.flash[:alert] = 'Try again, minus the errors'
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
