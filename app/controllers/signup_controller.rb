class SignupController < ApplicationController
  layout 'login'


  def new


    if params[:invitation_token].nil? then
      @organization = Organization.new
      @organization.users.build
      render :action => 'new_signup'
    else
# User sign-up via invitation
      invitation=Invitation.find_by_token(params[:invitation_token])
      if invitation.nil? then
        flash[:error] = "The invitation provided is not valid !! Please contact the person that sent you the invitation."
        redirect_to login_path
        return
      end

      @organization =invitation.sender.organization
      @user = @organization.users.new(:invitation_token => params[:invitation_token])
      @user.email=@user.invitation.recipient_email

      render :action => 'new_register'
    end

#    @user = User.new(:invitation_token => params[:invitation_token])
#    @user.email = @user.invitation.recipient_email if @user.invitation


  end

  def create


# -------------- New  User SignUP
    if not params[:organization].nil? then

      @organization=Organization.new(params[:organization])
      @organization.name = @organization.users[0].username if @organization.name.blank?
      @organization.users[0].is_pm=true

      if  @organization.save
        flash[:notice] = "Registration successful."
        redirect_to projects_path
      else
        render :action => 'new_signup'
      end

# -------------- User was invited
    else
      @user = User.new(params[:user])

      if @user.save
        flash[:notice] = "Registration successful."
        redirect_to baseline_requests_path

      else
        render :action => 'new_register'
      end

    end

  end

end
