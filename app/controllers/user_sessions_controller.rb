class UserSessionsController < ApplicationController
layout "login"
    def new
    @user_session = UserSession.new
  end
  
  def create
  @user_session = UserSession.new(params[:user_session])
  if @user_session.save
    flash[:notice] = "Successfully logged in."

    if current_user.is_pm? then
    redirect_to projects_path
    else
    redirect_to baseline_requests_path
    end
  else
    render :action => 'new'
  end
end

def destroy
  @user_session = UserSession.find
  @user_session.destroy
  flash[:notice] = "Successfully logged out."
  redirect_to login_path
end

end
