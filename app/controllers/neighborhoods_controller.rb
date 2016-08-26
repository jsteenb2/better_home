class NeighborhoodsController < ApplicationController

  def show
    data = {}
    data["name"] = "Downtown"
    @yelp_responses = YelpMain.get_yelp_poi("#{data["name"]} san francisco ca")
    @neighborhood_name = data["name"]
    @avg_cost = "100,000"
    @overall_score = "90"
    @walkscore = "90"
    @transitscore = "80"
    @factual = FactualMain.count_num(data["name"])
    @crime = "5"
    @distance = 4
  end

end
