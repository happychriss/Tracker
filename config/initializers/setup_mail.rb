if Rails.env.production? then
  ## production
  ## Action Mailer via googlemail

  ActionMailer::Base.smtp_settings = {
      :enable_starttls_auto => true,
      :address              => 'smtp.gmail.com',
      :port                 => 587,
      :domain               => 'engine.local',
      :authentication       => :plain,
      :user_name            => 'pmsfriend@gmail.com',
      :password             => 'Martin12'
  }

  ActionMailer::Base.default_url_options[:host] ="project-tracking.org"
else

##development

# Action Mailer via googlemail
  ActionMailer::Base.smtp_settings = {
      :enable_starttls_auto => true,
      :address              => 'smtp.gmail.com',
      :port                 => 587,
      :domain               => 'engine.local',
      :authentication       => :plain,
      :user_name            => 'wasteitall@gmail.com',
      :password             => 'Martin12'
  }

  ActionMailer::Base.default_url_options[:host] = "localhost:3000"

end



