class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale

      I18n.locale = params[:locale] || I18n.default_locale

  end
  def default_url_options

      { locale: I18n.locale }

  end
  def browser_locale(request)

     locales = request.env['HTTP_ACCEPT_LANGUAGE'] || ""

     locales.scan(/[a-z]{2}(?=;)/).find do |locale|

       I18n.available_locales.include?(locale.to_sym)

     end
  end
end
