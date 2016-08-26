class TestsController < ApplicationController
  def new
    @addressinformation = AddressInformation.new
    @total_neighborhoods = @addressinformation.total_neighborhoods
    @total_traffic_incidents = @addressinformation.total_traffic_incidents
    @traffic_incidents_in = @addressinformation.traffic_incidents_in("Central Sunset", 2015)
    @eviction_score = @addressinformation.eviction_score("Central Sunset", 2015)
    @fire_safety_score = @addressinformation.fire_safety_score("Inner Sunset", 2015)
    @crime_score = @addressinformation.crime_score("Inner Sunset", 2015)
    @fire_incidents_score = @addressinformation.fire_incidents_score("Outer Sunset", 2015)
    @traffic_violations_score = @addressinformation.traffic_violations_score("Outer Parkside", 2015)
  end
end
