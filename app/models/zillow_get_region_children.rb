# Aggregated results
class ZillowGetRegionChildren

  attr_reader :options, :results

  include HTTParty
  base_uri "www.zillow.com/"
  ZWSID = Rails.application.secrets.zillow_zwsid

  def initialize
    @options = { query: { 'zws-id' => ZWSID } }

    # must be at least either of the two
    @region_id
    @state

    # optional
    @county
    @city

    # type of subregions to retrieve; optional
    # e.g. state, county, city, zipcode, neighborhood
    @childtype
  end

  # Setters.
  def region_id=(id)
    @region_id = id
  end

  def county=(county)
    @county = county
  end

  def city=(city)
    @city = city
  end

  def state=(state)
    @state = state
  end

  def childtype=(type)
    @childtype = type
  end

  # Preparing the options hash.
  def prep_query
    @options[:query]['region_id'] = @region_id if @region_id
    @options[:query]['state'] = @state if @state
    @options[:query]['county'] = @countye if @county
    @options[:query]['city'] = @city if @city
    @options[:query]['childtype'] = @childtype if @childtype
    @options
  end

  def search
    @results = self.class.get("/webservice/GetRegionChildren.htm", @options)
  end

  def parsed_results
<<<<<<< 8b705e571b0621c48d8239fb3b09146abebb5552
    @results.parsed_response['regionchildren']['response']['list']['region']
=======
    @results.parsed_response
>>>>>>> Working on better parsed results.
  end


end