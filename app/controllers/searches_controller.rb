class SearchesController < ApplicationController

  def new
  end

  def create
<<<<<<< 0e3c48fd1fb31ba8252f0558664804b29cb06aa9
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
=======
>>>>>>> Basic view.
  end

  def show
    prep_deep_search
    @property = get_property
  end

  def index
<<<<<<< 0e3c48fd1fb31ba8252f0558664804b29cb06aa9
>>>>>>> Added view for search results
=======
    prep_region_children
    @neighborhoods = get_region_children
>>>>>>> Basic view.
  end

  private

<<<<<<< 0e3c48fd1fb31ba8252f0558664804b29cb06aa9
<<<<<<< dcf57c01bf33a401f5d639013cb9dff920dcdc82
    # Getting neighborhoods.
=======
>>>>>>> Added view for search results
=======
    # Getting neighborhoods.
>>>>>>> Basic view.
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
<<<<<<< 0e3c48fd1fb31ba8252f0558664804b29cb06aa9
<<<<<<< dcf57c01bf33a401f5d639013cb9dff920dcdc82
=======
>>>>>>> Basic view.

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
<<<<<<< 0e3c48fd1fb31ba8252f0558664804b29cb06aa9
=======
>>>>>>> Added view for search results
=======
>>>>>>> Basic view.
end
