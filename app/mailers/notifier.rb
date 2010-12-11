class Notifier < ActionMailer::Base


  def estimation_request(recipient, request)

    @estimation_url = edit_estimator_estimation_request_url(recipient.perishable_token, request.id)

    mail(
        :to      => recipient.email,
        :from    => request.task.project.pm.email,
        :subject =>    "Please report your project status for the Project '#{request.task.project.name}'")
  end

  def baseline_request(recipient, request)

    @estimation_url = edit_estimator_baseline_request_url(recipient.perishable_token, request.id)

    mail(
        :to      => recipient.email,
        :from    => request.task.project.pm.email,
        :subject =>    "Please report your initial Baseline for the Project '#{request.task.project.name}'")


  end


  def invitation(invitation, register_url)

    @invitation   =invitation
    @register_url = register_url

    mail(
        :to      => invitation.recipient_email,
        :from    =>     invitation.sender.email,
        :subject =>  'Invitation to join TRACKER as Estimator')

    invitation.update_attribute(:sent_at, Time.now)
  end


end
