class TestsController < ApplicationController
  def new
    @addressinformation = AddressInformation.new
    @total_neighborhoods = @addressinformation.total_neighborhoods
    #@traffic_incidents_in = @addressinformation.traffic_incidents_in("Tenderloin", 2015)
    @total_traffic_incidents = @addressinformation.total_traffic_incidents
    @eviction_score = @addressinformation.eviction_score("Mission", 2015)
    @fire_safety_score = @addressinformation.fire_safety_score("Mission", 2015)
    @crime_score = @addressinformation.crime_score("Mission", 2015)
    @fire_incidents_score = @addressinformation.fire_incidents_score("Mission", 2015)
  end
end
