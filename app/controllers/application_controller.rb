class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all # include all helpers, all the time
  require 'authlogic'
  require 'object_extension'
  helper_method :current_user, :is_admin?, :is_pm?, :require_user, :require_no_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to login_path
  end

  def set_view_by_estimation_type(request)
    case request.task.estimation_type

      when 'pert'
        @estimation_mode=:pert
      when 'linear'
        @estimation_mode=:linear
      else
        raise 'wrong estimation type in controler'
    end
  end

# used for email log-in via estimator_id
  def load_estimator_using_perishable_token
    if not current_user then
      @user = User.find_using_perishable_token(params[:estimator_id], 1.week)
      if not @user.nil? then
        UserSession.create(@user, true)
        @current_user=@user
      else
        flash[:notice] = "We're sorry, but we could not locate your account. " +
                "If you are having issues try copying and pasting the URL " +
                "from your email into your browser or restarting the " +
                "reset password process."
        redirect_to login_path
        return
      end
    end
    @estimator=current_user.becomes(Estimator)
  end


  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def is_admin?
    if current_user.is_admin==true or current_user.id==1 then
      return true
    else
      return false
    end
  end

  def is_pm?
    if current_user.is_pm==true or is_admin? then
      return true
    else
      return false
    end
  end

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end


  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  # todo : fix request_uri is deprecated
  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
