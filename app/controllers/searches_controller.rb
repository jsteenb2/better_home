class SearchesController < ApplicationController
  before_action :prep_gruff, only: [:index]

  def show
  end

  def create
    if current_user
      id = params[:id] || current_user.id
      @user = User.find_by_id(id)
      @user.update(white_listed_survey_params)
    end
    session[:location_id] = params[:user][:location_id]
    redirect_to neighborhoods_path
  end

  def index
    @location = grab_ll
    @coords = { lat: @location.lat, lon: @location.lng }
    prep_region_children
    get_region_children
    @neighborhoods = @client.parsed_results
    @names_zestimates = @client.zestimates
    @names_coordinates = @client.coordinates
    gruff_zestimates_image
    # gruff_coordinates_image
  end

  private
    # Getting neighborhoods.
    def prep_region_children
      @client = ZillowGetRegionChildren.new
      @client.state = @location.state_code
      @client.city = @location.city
      @client.childtype = 'neighborhood'
      @client.prep_query
      @client
    end

    def get_region_children
      @client.search
      @client.parsed_results
    end

    def grab_ll
      Geokit::Geocoders::GoogleGeocoder.geocode session[:location_id]
    end

    def white_listed_survey_params
      params.require(:user)
        .permit(  :cost_score,
                  :crime_score,
                  :transit_score,
                  :commute_score,
                  :walk_score )
    end

    def prep_gruff
      @gruff = GruffPie.new
    end

    def gruff_zestimates_image
      @gruff.title = "Zestimates per neighborhood"
      @names_zestimates.first(20).each do |result|
        @gruff.set_data(result[:name],result[:zestimate].to_i)
      end
      @gruff.write("zestimates_image.png")
    end

end