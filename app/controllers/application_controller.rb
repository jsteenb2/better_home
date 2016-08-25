class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def neighborhood_score(user, neighborhood)
    value = 100 -
      (crime_factor(user.crime_score, neighborhood['crime_score'].to_i) +
      cost_factor(user.cost_score, neighborhood['cost_score'].to_i) +
      transit_factor(user.transit_score, neighborhood['transit_score'].to_i) +
      walkscore_factor(user.walk_score, neighborhood['walk_score'].to_i) +
      commute_factor(user.commute_score, neighborhood['distance_from_poi'].to_i))
      value
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

    def crime_factor(scale, hood)
      (scale - 1) * hood
    end

    def commute_factor(scale, distance_from)
      if distance_from > 18.0
        factor = 5
      elsif distance_from > 11.0
        factor = 4
      elsif distance_from > 7.0
        factor = 3
      elsif distance_from > 5.0
        factor = 2
      elsif distance_from > 3.0
        factor = 1
      else
        factor = 0
      end
      (scale - 1) * factor
    end

    def cost_factor(scale, price)
      if price > 2_000_000
        factor = 5
      elsif price > 1_500_000
        factor = 4
      elsif price > 1_150_000
        factor = 3
      elsif price > 900_000
        factor = 2
      elsif price > 725_000
        factor = 1
      else
        factor = 0
      end
      (scale - 1) * factor
    end

    def walkscore_factor(scale, score)
      (scale - 1) * ( 5 - (score/20.0).ceil)
    end

    def transit_factor(scale, score)
      (scale - 1) * ( 5 - (score/20.0).ceil)
    end
end
