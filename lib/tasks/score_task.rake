require 'rake'

namespace :score_task do
  desc "Updating the score model in the database at midnight"
  task update_scores: [ 'db:seed' ] do
   
    puts "Reseeding database"

    Score.destroy_all

    neighborhoods = ["Mission", "Bernal Heights", "Central Richmind", "Excelsior", "Bayview", "Central Sunset", "Downtown", "Pacific Heights", "Nob Hill", "Visitacion Valley", "Parkside", "Inner Richmond", "South of Market", "Tenderloin", "Noe Valley", "Inner Sunset", "Outer Sunset", "Portola", "Russian Hill", "Outer Parkside"]

    @addressinformation = AddressInformation.new

    neighborhoods.each do |neighborhood|
      Score.create(neighborhood: neighborhood, eviction_score: @addressinformation.eviction_score(neighborhood, 2015), fire_safety_score: @addressinformation.fire_safety_score(neighborhood, 2015), crime_score: @addressinformation.crime_score(neighborhood, 2015), fire_incidents_score: @addressinformation.fire_incidents_score(neighborhood, 2015), traffic_score: @addressinformation.traffic_violations_score(neighborhood, 2015))
      puts "Done with neighborhood..."
    end
  end

end
