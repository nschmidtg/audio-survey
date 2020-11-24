class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :prevent_caching

  def set_locale
    I18n.locale = params[:lang] || locale_from_header
  end

  def locale_from_header
    header_locale = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
    if header_locale == "es" || header_locale == "ca" || header_locale == "gl" || header_locale == "eu"
      "es"
    else
      "en"
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
  
  private

  def prevent_caching
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
