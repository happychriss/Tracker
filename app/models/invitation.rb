class Invitation < ActiveRecord::Base



  attr_accessible :sender_id, :recipient_email, :token, :sent_at
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  validates_presence_of :recipient_email
  validates_format_of :recipient_email, :with => Authlogic::Regex.email

  validate :recipient_is_not_registered
  validate :email_format
  validate :sender_has_invitations, :if => :sender

  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender

  private

  def email_format

  end

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end

  def sender_has_invitations
    unless  sender.invitation_limit > 0
      errors.add_to_base 'You have reached your limit of invitations to send. Please contact the system administrator'
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def decrement_sender_count
    sender.decrement! :invitation_limit
  end
  
end
