class StaticController < ApplicationController
  before_action :set_locale
  def generate_user
    u = User.last.dup
    u.generate_token!
    u.save
    s1 = Song.new({
      user_id: u.id,
      url: "/audios/backward.wav"
    })
    s1.save(validate: false)
    s2 = Song.new({
      user_id: u.id,
      url: "/audios/signal.wav"
    })
    s2.save(validate: false)
    redirect_to "/users?token=#{u.token}&locale=#{locale}"
  end
  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
        locale :
        I18n.default_locale
  end
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  def default_url_options
    { locale: I18n.locale }
  end
  def finish
    session[:current_user_token] = nil
  end
end
