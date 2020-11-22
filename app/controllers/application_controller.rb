class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:lang] || locale_from_header# || I18n.default_locale
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

end
