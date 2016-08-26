class NeighborhoodsController < ApplicationController

  def show
    @params= JSON.parse(params["neighborhood"])
    @neighborhood_name = @params["name"] 
    @yelp_responses = YelpMain.get_yelp_poi("#{@neighborhood_name} san francisco ca")
    @avg_cost = "100,000"
    @overall_score = "90"
    @walkscore = "90"
    @transitscore = "80"
    @factual = FactualMain.count_num(@neighborhood_name)
    @crime = "5"
    @distance = 4
  end

end
