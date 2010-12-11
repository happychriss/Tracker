class Ability
  include CanCan::Ability


  def initialize(user)

    return false if user.nil?

    if user.is_admin?
      can :manage, :all
    else

      # user: current_user, my_user: user given as parameter

      can :all, User do |my_user|
        user.is_admin?  or my_user.id == user.id
      end

      can :create, User do
        user.is_pm?
      end

      can :read, User do |my_user|
        user.is_admin? or user.is_pm? or (not my_user.nil? and my_user.id == user.id)
      end

      can :update, User do |my_user|
        user.is_admin? or (user.is_pm? and org_member(user,my_user)) or my_user.id == user.id
      end

      can :all, Project do |project|
        user.becomes(Pm)==project.pm
      end

      can :all, Estimation do |estimation|
        (user.becomes(Estimator) == estimation.estimator) ||
        (user.becomes(Pm)==estimation.task.project.pm)
      end

      can :all, Baseline do |baseline|
     (user.becomes(Estimator) == baseline.estimator) ||
     (user.becomes(Pm)==baseline.task.project.pm)
      end
     
      can :all, Task do |task|
        user.becomes(Pm)==task.project.pm      
       end
    end

  end

  private
  def   org_member(pm,user)
    pm.organization.users.include?(user)
  end


end
