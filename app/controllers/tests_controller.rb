class TestsController < ApplicationController
  def new
    @addressinformation = AddressInformation.new
    @eviction_notices_neighborhood = @addressinformation.eviction_notices_in("Tenderloin", 2016)
    @total_evictions_year = @addressinformation.total_eviction_notices
    @firesafety_complaints_year = @addressinformation.firesafety_complaints_in("Tenderloin", 2016)
    @neighborhood_firesafety_complaints = @addressinformation.total_firesafety_complaints
    @total_neighborhoods = @addressinformation.total_neighborhoods
    @crime_in_neighborhood = @addressinformation.crime_in_neighborhood("Tenderloin", 2016)
    @total_crime = @addressinformation.total_crime
    @fire_incidents_in = @addressinformation.fire_incidents_in("Tenderloin", 2016)
    @total_fire_incidents = @addressinformation.total_fire_incidents
    #@traffic_incidents_in = @addressinformation.traffic_incidents_in("Tenderloin", 2016)
    @total_traffic_incidents = @addressinformation.total_traffic_incidents

  end
end
