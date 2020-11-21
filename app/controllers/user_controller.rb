class UserController < ApplicationController
  before_action :authenticate
  before_action :set_locale

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
