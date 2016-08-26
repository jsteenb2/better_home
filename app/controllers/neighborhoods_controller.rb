class NeighborhoodsController < ApplicationController

  def show
    data =  ActiveSupport::JSON.decode(params[:neighborhood])
    @yelp_responses = YelpMain.get_yelp_poi("#{data["name"]} san francisco ca")
    @neighborhood_name = data["name"]
    @avg_cost = data["cost_score"]
    @overall_score = data["overall_score"]
    @walkscore = WalkscoreMain.get_walkscore("#{data['name']} san francisco ca")
    @transitscore = WalkscoreMain.get_transitscore("#{data['name']} san francisco ca")
    @factual = FactualMain.count_num(data["name"])['category_ids']
    @crime = data["crime_score"]
    @distance = data["distance_from_poi"]
  end

end
