class WalkscoresController < ApplicationController

  def show
    @response = FactualMain.get_poi("Mission", 1000)
  end

end
