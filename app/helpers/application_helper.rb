module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') || ('https://') ? url : 'http://' + url
  end
end
