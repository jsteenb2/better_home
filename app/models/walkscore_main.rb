class WalkscoreMain

  def self.get_walkscore(address)
    url = build_url(address)
    #response = HTTParty.get(url)
    #p response
  end

  def self.build_url(address)
    url = "http://api.walkscore.com/score?format=json"
    url_hash = build_url_hash(address)
    url_hash.each do |key, val|
      url += "&#{key}=#{val}"
    end
    url
  end

  def self.build_url_hash(address)
    hash = {}
    hash["address"] = URI.encode(address)
    geocoded = Geokit::Geocoders::GoogleGeocoder.geocode address
    hash["lat"], hash["lon"] = geocoded.latitude, geocoded.longitude
    hash["wsapikey"] = Rails.application.secrets.walkscore_key
    hash
  end

end
