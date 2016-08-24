class SearchesController < ApplicationController

  def new
  end

  def create
    prep_region_children
    @neighborhoods = get_region_children
    render :index
  end

  def show
  end

  def index
  end

  private

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
end
