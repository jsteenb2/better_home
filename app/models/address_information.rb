require 'date'

class AddressInformation
  attr_reader :client

  def initialize
    @client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => ENV["SF_DATA_TOKEN"]})
  end

  def eviction_notices_in(neighborhood, year)
    zipcode = zipcode.to_s
    client.get("93gi-sfd2", {
      "$select" => "count(neighborhood) as neighborhood_evictions",
      "$where" =>  "neighborhood like '#{neighborhood}' and date_trunc_y(file_date) between '#{year}' and '2016'",
      "$group" => "neighborhood"
      })
  end

  def total_eviction_notices
    zipcode = zipcode.to_s
    client.get("93gi-sfd2", {
      "$select" => "count(neighborhood) as neighborhood_evictions",
      "$where" => "date_trunc_y(file_date) between '2016' and '2016'"
      })
  end

  def firesafety_complaints_in(neighborhood, year)
    client.get("x75j-u3wx", {
      "$select" => 'count(neighborhood_district) as neighborhood_fire_complaints',
      "$where" => "neighborhood_district like '#{neighborhood}' and date_trunc_y(violation_date) between '#{year}' and '2016'",
      })

  end

  def total_firesafety_complaints
    client.get("x75j-u3wx", {
      "$select" => 'count(neighborhood_district) as total_firesafety_complaints',
      "$where" => "date_trunc_y(violation_date) = '2016'"
      })
  end

  def total_neighborhoods
    client.get("x75j-u3wx", {
      "$select" => 'count(neighborhood_district)'
      })
  end


  def crime_in_neighborhood(neighborhood, year)
    client.get("cuks-n6tp", {
      "$select" => "count(pddistrict) as crimes_neighborhood",
      "$where" => "lower(pddistrict) like '#{neighborhood.downcase}' and date_trunc_y(date) between '#{year}' and '2016'"
      })
  end

  def total_crime
    client.get("cuks-n6tp", {
      "$select" => "count(incidntnum)",
      "$where" => "date_trunc_y(date) = '2016'"
      })
  end

  #Needs fixing
  def fire_incidents_in(neighborhood, year)
    @client.get("wr8u-xric", {
      "$select" => "count(neighborhood_district) as fire_incidents",
    })
  end

  def total_fire_incidents
    client.get("wr8u-xric", {
      "$select" => "count(neighborhood_district) as fire_incidents"
      })
  end

  # def traffic_incidents_in(neighborhood, year)
  #   client.get("vv57-2fgy", {
  #     "$select" => "count(pddistrict) as traffic_incidents",
  #     "$where" => "lower(pddistrict) like '#{neighborhood.downcase}' and date_trunc_y(date) between '#{year}' and '2016'"
  #     })
  # end

  def total_traffic_incidents
    client.get("vv57-2fgy", {
      "$select" => "count(incidntnum)",
      "$where" => "date_trunc_y(date) = '2016'"
      })
  end

end