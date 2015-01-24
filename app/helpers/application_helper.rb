module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') || ('https://') ? url : ('http://' + url)
  end

  def time_of_post(date)
    if date.nil?
      date
    else
      date.strftime("%A, %m/%d/%Y at %l:%M %P %Z")
    end
  end
end
