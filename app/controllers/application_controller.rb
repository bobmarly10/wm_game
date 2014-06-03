class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  before_filter :authenticate!
  before_filter :set_locale
  before_filter :set_timezone

  private

    #def force_user_reload!
    #  @current_user     = nil
    #  session[:user_id] = nil
    #end

    def authenticate!
      redirect_to '/auth/facebook' and return unless user_signed_in?
    end

    def set_locale
      I18n.locale = I18n.available_locales.include?(current_user.short_locale.to_sym) ? current_user.short_locale : :en   if user_signed_in?
    end

    def set_timezone
      if user_signed_in?
        time_zone_offset = current_user.timezone.to_i
        time_zone = ActiveSupport::TimeZone[time_zone_offset]
        if time_zone.now.utc_offset / 3600 != time_zone_offset
          time_zone = ActiveSupport::TimeZone[time_zone_offset-1]
        end
        Time.zone = time_zone.name
      end
    rescue => e
      nil
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue => e
      nil
    end

    def user_signed_in?
      !!current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

end
