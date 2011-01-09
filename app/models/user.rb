class User < ActiveRecord::Base

  acts_as_authentic

  has_many :tasks
  has_many :estimations
  has_many :baselines
  has_many :projects

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
#  accepts_nested_attributes_for :sent_invitations, :allow_destroy => true

  belongs_to :organization
  belongs_to :invitation

  validate :unique_invitation_id, :on => :create

#  validates_uniqueness_of :invitation_id


  before_create :set_invitation_limit

  def self.get_team(current_user)
    return User.all if current_user.is_admin?
    return current_user.organization.users.all unless current_user.is_admin?
  end

  def estimation_pending?
    estimator=self.becomes(Estimator)
    (estimator.baselines+estimator.estimations).each do |estimation|
      if estimation.estimation_allowed? then
        return true
      end
    end
    return false
  end

  def unique_invitation_id
    if not self.invitation_id.nil? then
      errors.add_to_base("User already accepted this invitation") if User.find_by_invitation_id(self.invitation_id)
    end
  end

  def notify_teammember(pm)
    reset_perishable_token!
    Notifier.invitation(self, pm)
  end


  def notify_estimator(request)
    reset_perishable_token!
    Notifier.estimation_request(self, request)
  end


  # manage invitations

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  private

  def set_invitation_limit
    self.invitation_limit = 5
  end


end
