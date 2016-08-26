class WalkscoreMain

#HTTParty.get("http://transit.walkscore.com/transit/score/?lat=47.6101359&lon=-122.3420567&city=Seattle&state=WA&wsapikey=4c1811146683d4a9656db9224300d8d3")


  def self.get_transitscore(neighborhood)
    rough_address = get_address(neighborhood).full_address
    address = format_address(rough_address)
    url = build_url(address, "transit")
    HTTParty.get(url)
  end

  def self.get_walkscore(address)
    url = build_url(address, "walk")
    HTTParty.get(url)
  end

  private

    def self.get_address(neighborhood)
      Geokit::Geocoders::GoogleGeocoder.api_key = Rails.application.secrets.google_maps_key
      Geokit::Geocoders::GoogleGeocoder.geocode neighborhood
      #Geokit::Geocoders::GoogleGeocoder.geocode geocoded
    end

    def self.format_address(address)
      address.split(",")[0..-2].map(&:strip).join(" ")
    end

    # Takes the type of call, "walk" or "transit", generates the begginning of a
    # url string and builds a hash of all the keys and values that string needs
    # to be built. Returns the final string
    def self.build_url(address, type)
      if type == "walk"
        url_hash = build_url_hash_walk(address)
        url_beginning = "http://api.walkscore.com/score?format=json"
      else
        url_hash = build_url_hash_transit(address)
        url_beginning = "http://transit.walkscore.com/transit/score/?"
      end
      build_url_string(url_beginning, url_hash)
    end

    # given a starting url_string and a hash of attributes, builds a final url
    # string to be submitted to the walkscore API. Returns a completed url string.
    def self.build_url_string(url, url_hash)
      url_hash.each do |key, val|
        if key == "city"
          url += "#{key}=#{val}"
        else
          url += "&#{key}=#{val}"
        end
      end
      url
    end

    def self.build_url_hash_transit(address)
      hash = get_city_state(address)
      hash = get_lat_long(address, hash)
      hash["wsapikey"] = Rails.application.secrets.walkscore_key
      hash
    end

    def self.get_city_state(address)
      hash = {}
      address_params = address.split(" ")
      hash["city"], hash["state"] = address_params[-3] + '%20' + address_params[-2], address_params[-1]
      hash
    end

    def self.get_lat_long(address, hash)
      Geokit::Geocoders::GoogleGeocoder.api_key = Rails.application.secrets.google_maps_key
      geocoded = Geokit::Geocoders::GoogleGeocoder.geocode address
      hash["lat"], hash["lon"] = geocoded.latitude, geocoded.longitude
      hash
    end


    def self.build_url_hash_walk(address)
      hash = {}
      hash["address"] = URI.encode(address)
      hash = get_lat_long(address, hash)
      hash["wsapikey"] = Rails.application.secrets.walkscore_key
      hash
    end

end
