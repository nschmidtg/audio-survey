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
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    I18n.available_locales.map(&:to_s).include?(browser_locale) ? browser_locale : nil
  end
  def default_url_options
    { locale: I18n.locale }
  end
end
