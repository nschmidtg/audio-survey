class StaticController < ApplicationController
  def finish
    session[:current_user_token] = nil
  end

  def generate_user
    u = User.last.dup
    u.generate_token!
    u.save
    Song.create({
      user_id: u.id,
      url: "/audios/backward.wav"
    })
    Song.create({
      user_id: u.id,
      url: "/audios/signal.wav"
    })
    redirect_to "/users?token=#{u.token}"
  end
end
