module TasksHelper
   require "uri"
 
  def text_url_to_link(text)
 
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      text.gsub!(url, "< a href=\"url\"target=\"_blank\">")
    end
    text
  end
end
