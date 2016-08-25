class WalkscoresController < ApplicationController

  def show
    search = YelpMain.get_yelp_poi("mission sanfrancisco ca")
    @response = search
    @neighborhood_name = "Mission"
  end

end
