class SearchesController < ApplicationController

  def new
  end

  def create
  end

  def show
    prep_deep_search
    @property = get_property
    @coords = get_coords
  end

  def index
    @coords = ActiveSupport::JSON.decode(params['coords'])
    prep_region_children
    @neighborhoods = get_region_children
    @names_zestimates = @client.zestimates
    @names_coordinates = @client.coordinates
    gruff_zestimates_image
    gruff_coordinates_image
  end

  private
    # Getting neighborhoods.
    def prep_region_children
      @client = ZillowGetRegionChildren.new
      params.except(:utf8,:authenticity_token,:controller,:action,:commit,:coords).each do |k,v|
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
      distances = @names_coordinates.first(15).map do |result|
        # computing for distance from user
        distance_from_user = (result[:coords][:lat].to_f.abs - @coords[:lat].to_f.abs) + (result[:coords][:lon].to_f.abs - @coords[:lon].to_f.abs)
        {name: result[:name], distance: distance_from_user}
      end
      @gruff.title = "Each neighborhood's distance from user"
      distances.each do |result|
        @gruff.set_data(result[:name],result[:distance])
      end
      @gruff.write("coordinates_image.png")
    end

end