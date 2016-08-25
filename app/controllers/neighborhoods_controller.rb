class NeighborhoodsController < ApplicationController

  def show
    data = ActiveSupport::JSON.decode(params[:neighborhood])
    params[:neighborhood] = "Mission"
    @yelp_responses = YelpMain.get_yelp_poi("#{params[:neighborhood]} san francisco ca")
    @neighborhood_name = params[:neighborhood]
    @avg_cost = "1234"
    @overall_score = "98"
    @walkscore = WalkscoreMain.get_walkscore("#{params[:neighborhood]} san francisco ca")
    @transitscore = WalkscoreMain.get_transitscore("#{params[:neighborhood]} san francisco ca")
    @factual = FactualMain.count_num(params[:neighborhood])
  end

end
