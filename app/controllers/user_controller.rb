class UserController < ApplicationController
  before_action :authenticate

  def show
    @hola = @current_user.email
  end

  private

  def authenticate
    @current_user = User.find_by(token: params[:token])
    unless @current_user
      raise ActiveRecord::RecordNotFound
    end
    session[:current_user_token] ||= @current_user.token
  end
end
