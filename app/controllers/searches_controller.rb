class SearchesController < ApplicationController

  def new
  end

  def create
<<<<<<< dcf57c01bf33a401f5d639013cb9dff920dcdc82
  end

  def show
    prep_deep_search
    @property = get_property
  end

  def index
    prep_region_children
    @neighborhoods = get_region_children
=======
    prep_region_children
    @neighborhoods = get_region_children
    render :index
  end

  def show
  end

  def index
>>>>>>> Added view for search results
  end

  private

<<<<<<< dcf57c01bf33a401f5d639013cb9dff920dcdc82
    # Getting neighborhoods.
=======
>>>>>>> Added view for search results
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
<<<<<<< dcf57c01bf33a401f5d639013cb9dff920dcdc82

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
=======
>>>>>>> Added view for search results
end
