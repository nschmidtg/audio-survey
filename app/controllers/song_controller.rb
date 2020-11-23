class SongController < ApplicationController
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

  def show
    redirect_to edit_song_path(id: params[:id])
  end

  def update
    if @song.update_attributes(params_song)
      @song.update_attribute(:completed, true)
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
    @song = @current_user.songs.where(id: params[:id], completed: false).first
    if @song
      @total = @song.user.songs.count
      @completed = @song.user.songs.where(completed: true).count
    else
      flash[:error] = t(:error)
      redirect_to "/users?token=#{@current_user.token}"
    end
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
      flash[:error] = t(:error)
      redirect_to root_path
    end
  end
end
