module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') || ('https://') ? url : 'http://' + url
  end

  def time_of_post(date)
  	if date.nil?
      date
    else
      date.rfc822
    end
  end
end
