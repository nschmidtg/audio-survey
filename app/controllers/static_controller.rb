class StaticController < ApplicationController
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
    redirect_to "/users?token=#{u.token}&locale=#{I18n.locale}"
  end
end
