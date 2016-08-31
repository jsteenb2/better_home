FactoryGirl.define do
  factory :user do
    name 'CJ'
    password 'foobarbaz'
    age 29
    email 'cjvirtucio@example.com'
    location_id 4
    walk_score 3
    transit_score 4
    commute_score 2
    cost_score 2
    crime_score 4
  end
end
