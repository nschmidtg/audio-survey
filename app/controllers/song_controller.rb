class SongController < ApplicationController
  before_action :authenticate
  before_action :find_song, only: [:edit, :update]

  def start_survey
    next_song = @current_user.songs.where(compleated: false).first
    if next_song
      redirect_to edit_song_path(next_song.id)
    else
      redirect_to finish_path
    end
  end

  def edit
  end

  def update
    puts params
    if @song.update_attributes(params_song)
      @song.update_attribute(:compleated, true)
      flash[:notice] = 'Imagen acutalizada'
      next_song = @song.user.songs.where(compleated: false).first
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
    @compleated = @song.user.songs.where(compleated: true).count
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
end
