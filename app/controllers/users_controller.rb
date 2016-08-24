class UsersController < ApplicationController
  def survey
    @user = User.new
    render 'survey'
  end

  def survey_results
    @user = User.find_by_id(2)
    @user.update(white_listed_survey_params)
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end

  def white_listed_survey_params
    params.require(:user).permit( :cost_score, :crime_score,
                                  :transit_score, :commute_score,
                                  :walk_score )
  end
end
