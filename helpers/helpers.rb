helpers Sinatra::Partials

helpers do

  # ididitmyway.heroku.com/past/2010/4/25/sinatra_helpers
  def link_to(url, text = url, opts = {})
    attributes = ""
    opts.each { |key,value|
      attributes << key.to_s << "=\"" << value << "\" "
    }
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
  
  # from actionview
  def escape_javascript(javascript)
    if javascript
      javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { JS_ESCAPE_MAP[$1] }
    else
      ''
    end
  end
  
  # modified from actionview (plural required, no inflector class)
  def pluralize(count, singular, plural)
    "#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : plural)
  end

end