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
end
