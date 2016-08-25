# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying current scores . . . . . . "
Score.destroy_all

neighborhoods = ["Mission", "Bernal Heights", "Central Richmind", "Excelsior", "Bayview", "Central Sunset", "Downtown", "Pacific Heights", "Nob Hill", "Visitacion Valley", "Parkside", "Inner Richmond", "South of Market", "Tenderloin", "Noe Valley", "Inner Sunset", "Outer Sunset", "Portola", "Russian Hill", "Outer Parkside"]

@addressinformation = AddressInformation.new

puts "Finding scores . . . . . . "
neighborhoods.each do |neighborhood|
  puts "Scouring neighborhood . . . . . . "
  Score.create(neighborhood: neighborhood, eviction_score: @addressinformation.eviction_score(neighborhood, 2015), fire_safety_score: @addressinformation.fire_safety_score(neighborhood, 2015), crime_score: @addressinformation.crime_score(neighborhood, 2015), fire_incidents_score: @addressinformation.fire_incidents_score(neighborhood, 2015), traffic_score: @addressinformation.traffic_violations_score(neighborhood, 2015))
end

puts "Scores obtained successfully!"
