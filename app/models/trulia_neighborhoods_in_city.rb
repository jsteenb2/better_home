class TruliaNeighborhoodsInCity

  attr_reader :options, :results

  include HTTParty
  base_uri "api.trulia.com/"
  API_KEY = Rails.application.secrets.trulia_api_key

  def initialize
    @options = { query: { 'apikey' => API_KEY, 'libary' => 'LocationInfo', 'function' => 'getNeighborhoodsInCity' } }
  end

  # Setters.

  def city=(city)
    @city = city
  end

  def state=(state)
    @state = state
  end

  # Preparing the options hash.
  def prep_query
    @options[:query]['city'] = @city
    @options[:query]['state'] = @state
    @options
  end

  def search
    @results = self.class.get("/webservices.php", @options)
  end

  def parsed_results
    @results.parsed_response
  end

end