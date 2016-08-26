require 'date'

class AddressInformation
  attr_reader :client

  @@neighborhood_to_pd = {"mission" => "mission", "bernal heights" => "ingleside", "central richmond" => "richmond", "excelsior" => "ingleside", "bayview" => "bayview", "central sunset" => "taraval", "downtown" => "tenderloin", "pacific heights" => "northern", "nob hill" => "central", "visitacion valley" => "ingleside", "parkside" => "taraval", "inner richmond" => "richmond", "south of market" => "southern", "tenderloin" => "tenderloin", "noe valley" => "ingleside", "inner sunset" => "taraval", "outer sunset" => "taraval", "portola" => "bayview", "russian hill" => "central", "outer parkside" => "taraval"}

  #Population for 2008 census
  @@neighborhood_population = {"mission" => 47234, "bernal heights" => 24824, "central richmond" =>   59297, "excelsior" => 23823, "bayview" => 35890, "central sunset" => 21791, "downtown" => 38728, "pacific heights" => 23545, "nob hill" => 20388, "visitacion valley" =>  22534, "parkside" => 27640, "inner richmond" => 38939, "south of market" => 23016, "tenderloin" => 25067, "noe valley" => 21106, "inner sunset" => 38892, "outer sunset" =>  77431, "portola" => 12760, "russian hill" => 56322, "outer parkside" => 14334}

  @@police_population = {"mission" => 47234 / 653561.0 , "ingleside" => (24824 + 23823 + 22534 + 21106) / 653561.0, "richmond" =>  (59297 + 38939) / 653561.0, "bayview" => (35890 + 12760) / 653561.0, "taraval" => (27640 + 38892 + 77431 + 14334 + 21791) / 653561.0, "central" => (56322 + 20388) / 653561.0, "tenderloin" => (38728 + 25067) / 653561.0, "southern" => 23016 / 653561.0, "northern" => 23545 / 653561.0}

  @@total_population = 653561.0

  def initialize
    @client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => ENV["SF_DATA_TOKEN"]})
  end

  def convert_to_station(neighborhood)
    @@neighborhood_to_pd[neighborhood]
  end

  def eviction_notices_in(neighborhood, year)
    zipcode = zipcode.to_s
    client.get("93gi-sfd2", {
      "$select" => "count(neighborhood) as neighborhood_evictions",
      "$where" =>  "lower(neighborhood) like '#{neighborhood.downcase}' and date_trunc_y(file_date) between '#{year}' and '2015'",
      "$group" => "neighborhood"
      })
  end

  def total_eviction_notices
    zipcode = zipcode.to_s
    client.get("93gi-sfd2", {
      "$select" => "count(neighborhood) as evictions",
      "$where" => "date_trunc_y(file_date) between '2015' and '2015'"
      })
  end

  def firesafety_complaints_in(neighborhood, year)
    client.get("x75j-u3wx", {
      "$select" => 'count(neighborhood_district) as neighborhood_fire_complaints',
      "$where" => "neighborhood_district like '#{neighborhood}' and date_trunc_y(violation_date) between '#{year}' and '2015'",
      })

  end

  def total_firesafety_complaints
    client.get("x75j-u3wx", {
      "$select" => 'count(neighborhood_district) as total_firesafety_complaints',
      "$where" => "date_trunc_y(violation_date) = '2015'"
      })
  end

  def total_neighborhoods
    20
  end


  def crime_in_neighborhood(neighborhood, year)
    client.get("cuks-n6tp", {
      "$select" => "count(pddistrict) as crimes_neighborhood",
      "$where" => "lower(pddistrict) like '#{convert_to_station(neighborhood).downcase}' and date_trunc_y(date) between '#{year}' and '2015'"
      })
  end

  def total_crime
    client.get("cuks-n6tp", {
      "$select" => "count(incidntnum)",
      "$where" => "date_trunc_y(date) = '2015'"
      })
  end

  def fire_incidents_in(neighborhood, year)
    @client.get("wbb6-uh78", {
      "$select" => "count(neighborhood_district) as fire_incidents",
      "$where" => "'#{neighborhood.downcase}' like lower(neighborhood_district) and date_trunc_y(alarm_dttm) between '2015' and '#{year}'"
    })
  end

  def total_fire_incidents
    client.get("wbb6-uh78", {
      "$select" => "count(neighborhood_district) as fire_incidents",
      "$where" => "date_trunc_y(alarm_dttm) = '2015'"
      })
  end

  def traffic_incidents_in(neighborhood, year)
    client.get("cuks-n6tp", {
      "$select" => "count(descript) as traffic_incidents",
      "$where" => "lower(pddistrict) like '#{convert_to_station(neighborhood).downcase}' and date_trunc_y(date) = '2015'"
      })
  end

  def total_traffic_incidents
    client.get("cuks-n6tp", {
      "$select" => "count(descript)",
      "$where" => "date_trunc_y(date) = '2015'"
      })
  end

  def neighborhood_population_ratio(neighborhood)
    @@neighborhood_population[neighborhood] / @@total_population
  end

  def police_population_ratio(neighborhood)
    @@police_population[convert_to_station(neighborhood)]
  end


  def eviction_score(neighborhood, year)
    return 2 if eviction_notices_in(neighborhood, year) == []
    score = ((eviction_notices_in(neighborhood, year).first.first[1].to_i.to_f / total_eviction_notices.first.first[1].to_i) / neighborhood_population_ratio(neighborhood)) * 2.5
    if score >= 5.0
      5
    else
      score.round
    end
  end

  def fire_safety_score(neighborhood, year)
    score = ((firesafety_complaints_in(neighborhood, year).first.first[1].to_i.to_f / total_firesafety_complaints.first.first[1].to_i) / neighborhood_population_ratio(neighborhood)) * 2.5
    if score >= 5.0
      5
    else
      score.round
    end
  end

  def crime_score(neighborhood, year)
    score = ((crime_in_neighborhood(neighborhood, year).first.first[1].to_i.to_f / total_crime.first.first[1].to_i) / police_population_ratio(neighborhood)) * 2.5
    if score >= 5.0
      5
    else
      score.round
    end
  end

  def fire_incidents_score(neighborhood, year)
    score = ((fire_incidents_in(neighborhood, year).first.first[1].to_i.to_f / total_fire_incidents.first.first[1].to_i) / neighborhood_population_ratio(neighborhood)) * 2.5
    if score >= 5.0
      5
    else
      score.round
    end
  end

  def traffic_violations_score(neighborhood, year)
    score = ((traffic_incidents_in(neighborhood, year).first.first[1].to_i.to_f / total_traffic_incidents.first.first[1].to_i) / police_population_ratio(neighborhood)) * 2.5
    if score >= 5.0
      5
    else
      score.round
    end
  end
end
