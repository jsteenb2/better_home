class SearchesController < ApplicationController

  def show
    prep_deep_search
    @property = get_property
  end

  def create
    location = grab_ll
    if current_user
      id = params[:id] || current_user.id
      @user = User.find_by_id(id)
      @user.update(white_listed_survey_params)
    end
    # render 'index', locals: {location: location}
  end

  def index
    #results are from create action
    prep_region_children
    @neighborhoods = get_region_children
  end

  private
    # Getting neighborhoods.
    def prep_region_children
      @client = ZillowGetRegionChildren.new
      params.except(:utf8,:authenticity_token,:controller,:action,:commit).each do |k,v|
        unless v == ''
          @client.send("#{k}=",v)
        end
      end
      @client.childtype = 'neighborhood'
      @client.prep_query
      @client
    end

    def get_region_children
      @client.search
      @client.parsed_results
    end

    # Getting a property.
    def prep_deep_search
      @client = ZillowDeepSearch.new
      params.except(:utf8,:authenticity_token,:controller,:action,:commit).each do |k,v|
        unless v == ''
          @client.send("#{k}=",v)
        end
      end
      @client.prep_query
      @client
    end

    def get_property
      @client.search
      @client.parsed_results
    end

    def grab_ll
      Geokit::Geocoders::GoogleGeocoder.geocode params[:user][:location_id]
    end

    def white_listed_survey_params
      params.require(:user)
        .permit(  :cost_score,
                  :crime_score,
                  :transit_score,
                  :commute_score,
                  :walk_score )
    end
end
