class SearchesController < ApplicationController

  def create
    if current_user
      id = params[:id] || current_user.id
      @user = User.find_by_id(id)
      @user.update(white_listed_survey_params)
    end
    session[:location_id] = params[:user][:location_id]
    redirect_to searches_path
  end

  def index
    @location = grab_ll
    @coords = { lat: @location.lat, lon: @location.lng }
    prep_region_children
    @neighborhoods = get_region_children
    @names_zestimates = @client.zestimates
    @names_coordinates = @client.coordinates
    @names_coordinates_json = @names_coordinates.first(15).to_json
    get_distances
    # gruff_zestimates_image
    # gruff_coordinates_image
    build_neighbor_packages
    sort_by_overall_score
  end

  private
    def get_distances
      start = @location
      Geokit::Geocoders::GoogleGeocoder.api_key = Rails.application.secrets.google_maps_key
      @distances = @names_coordinates.first(15).map do |result|
        # computing for distance from user

        end_point = Geokit::Geocoders::GoogleGeocoder.geocode("#{result[:name]} san francisco ca")
        distance_from_user = @location.distance_to(end_point)
      end
    end


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

    def get_coords
      @client.coords
    end

    def get_coords
      @client.coords
    end

    def prep_gruff
      @gruff = GruffPie.new
    end

    def gruff_zestimates_image
      prep_gruff
      @gruff.title = "Zestimates per neighborhood"
      @names_zestimates.first(15).each do |result|
        @gruff.set_data(result[:name],result[:zestimate].to_i)
      end
      @gruff.write("zestimates_image.png")
    end

    def get_coords
      @client.coords
    end

    def prep_gruff
      @gruff = GruffPie.new
    end

    def gruff_zestimates_image
      prep_gruff
      @gruff.title = "Zestimates per neighborhood"
      @names_zestimates.first(15).each do |result|
        @gruff.set_data(result[:name],result[:zestimate].to_i)
      end
      @gruff.write("zestimates_image.png")
    end

    def gruff_coordinates_image
      prep_gruff
      @distances = @names_coordinates.first(15).map do |result|
        # computing for distance from user
        distance_from_user = -(result[:coords][:lat].to_f.abs - @coords[:lat].to_f.abs) + (result[:coords][:lon].to_f.abs - @coords[:lon].to_f.abs).abs
        {result[:name] => distance_from_user}
      end
      @gruff.title = "Each neighborhood's distance from user"
      @distances.each do |k,v|
        @gruff.set_data(k,v)
      end
      @gruff.write("coordinates_image.png")
    end


    def build_neighbor_packages
      @neighborhood_container = []
      @neighborhoods[0..14].each_with_index do |neighbor,i|
        hood_hash = {}
        hood_hash = get_walkscore_stuff(neighbor, hood_hash)
        hood_hash = get_zillow_stuff(neighbor, hood_hash, i)
        hood_hash = add_crime_score(neighbor, hood_hash)
        hood_hash = add_overall_score(neighbor, hood_hash)
        @neighborhood_container << hood_hash
      end
    end

    def add_crime_score(neighbor,hash)
      if neighborhood = Score.find_by_neighborhood(neighbor['name'])
        hash['crime_score'] = neighborhood.crime_score
      else
        hash['crime_score'] = 3
      end
      hash
    end

    def add_overall_score(neighbor,hash)
      hash['overall_score'] = neighborhood_score(current_user,hash)
      hash
    end

    def get_walkscore_stuff(neighbor, hash)
      walk = WalkscoreMain.get_walkscore("#{neighbor["name"]} san francisco ca")
      transit = WalkscoreMain.get_transitscore("#{neighbor["name"]} san francisco ca")
      hash["name"] = neighbor["name"]
      hash["walk_score"] = walk["walkscore"]
      hash["transit_score"] = transit["transit_score"]
      hash["walk_description"] = walk["description"]
      hash["transit_description"] = transit["summary"]
      hash
    end

    def get_zillow_stuff(neighbor, hash, idx)
      unless neighbor["zindex"].nil?
        hash["cost_score"] = neighbor["zindex"]["__content__"]
      end
      hash["lat"] = neighbor["latitude"]
      hash["long"] = neighbor["longitude"]
      hash["distance_from_poi"] = @distances[idx]
      hash
    end

    def sort_by_overall_score
      @neighborhood_container = @neighborhood_container.sort do |a,b|
        b['overall_score'] <=> a['overall_score']
      end
    end

end
