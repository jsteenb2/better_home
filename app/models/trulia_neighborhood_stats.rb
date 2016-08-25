class TruliaNeighborhoodStats

  attr_reader :options, :results

  include HTTParty
  base_uri "api.trulia.com"
  API_KEY = Rails.application.secrets.trulia_api_key

  def initialize
    @options = { query: { 'apikey' => API_KEY, 'libary' => 'TruliaStats', 'function' => 'getNeighborhoodStats' } }
  end

  # Setters.
  def neighborhood_id=(id)
    @neighborhoodid = id
  end

  def start_date=(date)
    @start_date = date
  end

  def end_date=(date)
    @end_date = date
  end

  def stat_type=(listings)
    @stat_type = listings
  end

  # Preparing the options hash.
  def prep_query
    @options[:query]['neighborhoodid'] = @neighborhoodid
    @options[:query]['startdate'] = @start_date
    @options[:query]['enddate'] = @end_date
    @options[:query]['stattype'] = @stat_type
    @options
  end

  def search
    @results = self.class.get("/webservices.php", @options)
  end

  def parsed_results
    @results.parsed_response
  end

end