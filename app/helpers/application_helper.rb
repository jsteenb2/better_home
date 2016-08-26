module ApplicationHelper

  def get_commute(distance, speed)
    ((distance.to_f / speed.to_f) * 60).round(2)
  end

end
