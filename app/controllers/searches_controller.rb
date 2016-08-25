class SearchesController < ApplicationController

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
    @neighborhoods = get_region_children
  end

  def show
    prep_deep_search
    @property = get_property
  end

  def index
    prep_region_children
    # @neighborhoods = get_region_children
    get_region_children
    @neighborhoods = @client.zestimates
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

end