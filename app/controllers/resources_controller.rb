class ResourcesController < ApplicationController

  before_filter :set_tags, except: :destroy

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resources }
    end
  end

  #  =Manage
  # Result of combining #new #edit #update #create
  # * /manage/:id(.format)
  # * /manage(.:format)
  def manage
    @resource = Resource.where(id: params[:id]).first_or_initialize

    # set flags for check boxes - GET
    @resource.add_coordinates = @resource.location && @resource.location.coords_set?
    @resource.add_location = !(@resource.location || @resource.build_location).new_record?

    if request.post? || request.put?
      @resource.transaction do
        r_param = params[:resource]
        l_param = r_param[:location]

        # set flags from check boxes
        @resource.add_location = r_param[:add_location] != '0'
        @resource.add_coordinates = r_param[:add_coordinates] != '0'

        # set resource attributes
        @resource.name = r_param[:name]
        @resource.url = r_param[:url]

        # save tags
        @resource.tag_list = r_param[:tag_list]

        if @resource.add_location
          l_param = l_param.except(*Location.coords) unless @resource.add_coordinates

          @resource.location = Location.find_or_initialize_by_address_and_region_id(l_param[:address], l_param[:region_id])
          @resource.location.state = 'HI'
          @resource.location.set_coords(l_param)
          @resource.location.save!
        else
          @resource.location.try(:destroy) unless Resource.find_all_by_location_id(@resource.location.try(:id))
          @resource.location = nil
        end

        @resource.save!
        redirect_to(resources_path, notice: "#{@resource.name} was saved")
      end
    end
  rescue
    request.flash[:alert] = "Try again, minus the errors. #{@resource.errors.full_messages.first}"
  end

  # DELETE /resources/1
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    redirect_to(resources_path, notice: "#{@resource.name} was deleted")
  end

  private

  def set_tags
    @tags ||= ActsAsTaggableOn::Tag.all.map { |t| t.name.titleize }
  end
end
