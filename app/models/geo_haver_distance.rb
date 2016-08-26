class GeoHaverDistance
  attr_reader :distance_mi
  MAX_DISTANCE_AWAY_IN_KM = 100.0
  RAD_PER_DEG             = 0.017453293

  Rmiles  = 3956           # radius of the great circle in miles
  Rkm     = 6371           # radius in kilometers, some algorithms use 6367
  Rfeet   = Rmiles * 5282  # radius in feet
  Rmeters = Rkm * 1000     # radius in meters

  def initialize(lat1, lon1, lat2, lon2)
    @distance_mi = haversine_distance( lat1, lon1, lat2, lon2 )
  end

  def haversine_distance( lat1, lon1, lat2, lon2 )
    dlon = lon2 - lon1
    dlat = lat2 - lat1

    dlon_rad = dlon * RAD_PER_DEG
    dlat_rad = dlat * RAD_PER_DEG

    lat1_rad = lat1 * RAD_PER_DEG
    lon1_rad = lon1 * RAD_PER_DEG

    lat2_rad = lat2 * RAD_PER_DEG
    lon2_rad = lon2 * RAD_PER_DEG

    a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) *
         Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

    dMi     = Rmiles * c      # delta between the two points in miles
    dKm     = nil # Rkm * c         # delta in kilometers
    dFeet   = nil #Rfeet * c       # delta in feet
    dMeters = nil #Rmeters * c     # delta in meters

    # { :mi => dMi, :km => dKm, :ft => dFeet, :m => dMeters }
    dMi
  end

  # property_count, too_far_away_count = 0, 0
  #
  # Property.find(:all, :conditions => ['location_id IS NOT NULL AND latitude IS NOT NULL AND longitude IS NOT NULL'], :joins => :location).each do |p|
  #   distance = haversine_distance(p.latitude, p.longitude, p.location.lat, p.location.lng)
  #   if distance[:km] > MAX_DISTANCE_AWAY_IN_KM
  #     puts "#{distance[:km].to_i} - Property:#{p.id} is #{distance[:km]} (km) from Location:#{p.location_id}"
  #     too_far_away_count += 1
  #   end
  #   property_count += 1
  # end

  # puts "Summary, #{property_count} scanned, #{too_far_away_count} deemed too far away (more than #{MAX_DISTANCE_AWAY_IN_KM})"
end
