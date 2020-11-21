class SongController < ApplicationController
  before_action :set_locale
  before_action :authenticate
  before_action :find_song, only: [:edit, :update]

  def start_survey
    next_song = @current_user.songs.where(completed: false).first
    if next_song
      redirect_to edit_song_path(next_song.id)
    else
      redirect_to finish_path
    end
  end

  def edit
  end

  def update
    if @song.update_attributes(params_song)
      @song.update_attribute(:completed, true)
      flash[:notice] = 'Imagen acutalizada'
      next_song = @song.user.songs.where(completed: false).first
      if next_song
        redirect_to edit_song_path(next_song.id)
      else
        redirect_to finish_path
      end
    else
      render 'edit'
    end
  end

  private

  def find_song
    @song = Song.find(params[:id])
    @total = @song.user.songs.count
    @completed = @song.user.songs.where(completed: true).count
  end

  def params_song
    params.require(:song).permit(
        :rating,
        :memory_description,
        :recognized,
        :recognize_text,
        :additional_description
      )
  end

  def authenticate
    @current_user = User.find_by(token: session[:current_user_token])
    unless @current_user
      raise ActiveRecord::RecordNotFound
    end
  end

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
