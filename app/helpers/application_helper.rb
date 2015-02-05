module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://' || 'https://') ? url : 'http://' + url
  end

  def time_of_post(dt)
    # if dt.nil?
    #   dt
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone).strftime("%A, %m/%d/%Y at %l:%M %P %Z")
    else
      dt = dt.strftime("%A, %m/%d/%Y at %l:%M %P %Z")
    end
  end
end
