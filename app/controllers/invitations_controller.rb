class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])

    @invitation.sender = current_user
    if @invitation.save
        Notifier.invitation(@invitation, register_url(@invitation.token)).deliver
        flash[:notice] = "Thank you, invitation sent."
        @invitation.update_attribute(:accepted_at, Time.now)
        redirect_to users_url
    else
      render :action => 'new'
    end
  end
end
