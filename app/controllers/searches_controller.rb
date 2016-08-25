class SearchesController < ApplicationController
  before_action :prep_gruff, only: [:index]

  def new
  end

  def create
  end

  def show
    prep_deep_search
    @property = get_property
  end

  def index
    prep_region_children
    # @neighborhoods = get_region_children
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