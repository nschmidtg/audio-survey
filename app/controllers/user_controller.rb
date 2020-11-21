class UserController < ApplicationController
  before_action :authenticate

  def show
    @go = true
    if @current_user.songs.where(completed: false).count == 0
      @email = "You have already responded the survey"
      @go = false
    else
      @email = @current_user.email
    end
  end

  private

  def authenticate
    session[:current_user_token] = nil
    @current_user = User.find_by(token: params[:token])
    unless @current_user
      raise ActiveRecord::RecordNotFound
    end
    session[:current_user_token] ||= @current_user.token
  end
end
