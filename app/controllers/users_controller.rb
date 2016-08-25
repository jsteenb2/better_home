class UsersController < ApplicationController


  def survey
    @user = User.new
  end

  def survey_results
    id = params[:id] || current_user.id
    @user = User.find_by_id(id)
    @user.update(white_listed_survey_params)
    redirect_to @user
  end

  def show
    id = params[:id] || current_user.id
    @user = User.find(id)
  end

  private
    def white_listed_survey_params
      params.require(:user)
        .permit(  :cost_score, 
                  :crime_score,
                  :transit_score, 
                  :commute_score,
                  :walk_score )
    end
end
