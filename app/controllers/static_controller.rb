class StaticController < ApplicationController
  before_action :set_locale

  def finish
    session[:current_user_token] = nil
  end

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
    redirect_to "/users?token=#{u.token}"
  end

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
