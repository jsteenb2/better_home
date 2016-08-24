class WalkscoresController < ApplicationController

  def show
    @response = WalkscoreMain.get_transitscore("3404 Harden Road Raleigh NC 27607")
  end

end
