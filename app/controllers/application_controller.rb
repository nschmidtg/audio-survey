class ApplicationController < ActionController::Base
  before_action :set_locale

  private
  def set_locale
    locale = extract_locale
    I18n.locale = I18n.available_locales.include?(locale) ?
        locale :
        I18n.default_locale
  end
  def extract_locale
    locales = request.env['HTTP_ACCEPT_LANGUAGE'].to_s
    locales.scan(/[a-z]{2}(?=;)/).find do |locale|
      I18n.available_locales.include?(locale.to_sym)
    end
  end
  def default_url_options
    { locale: I18n.locale }
  end
end
