require 'httparty'

class ZillowAPI
  attr_reader :options

  include HTTParty
  base_uri "www.zillow.com/"
  ZWSID = Rails.application.secrets.zillow_zwsid

  def initialize
    @options = { query: { 'zws-id' => ZWSID } }
    @street_address
    @city
    @state
    @zip
  end

  # Setters.
  def street_address=(address)
    @street_address = address
  end

  def city=(city)
    @city = city
  end

  def state=(state)
    @state = state
  end

  def zip=(zip)
    @zip = zip
  end

  # Preparing the options hash.
  def prep_query
    @options[:query][:address] = @street_address
    @options[:query][:citystatezip] = "#{@city} #{@state}"
    if @zip
      @options[:query][:citystatezip] += " #{@zip}"
    end
  end

  def search
    self.class.get("/webservice/GetDeepSearchResults.htm", @options)
  end

end