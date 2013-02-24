class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    # if user.admin?
    #   can :manage, :all
    # else
    #   can :read, ScavengerHunt, :users => {  }
    # end

    # Anyone can create a hunt
    can :create, Hunt

    # Can see hunts if you are a participant or you've been invited
    can :read, Hunt, :hunt_participants => { :user_id => user.id }
    can :read, Hunt, :hunt_invitations => { :user_id => user.id, :status => :invited }

    # Only judges can update hunts
    can :update, Hunt, :hunt_participants => { :user_id => user.id, :status => :judge }

    # Only judges can create clues
    can :create, Clue, :hunt => { :hunt_participants => { :user_id => user.id, :status => :judge } }

    # Only judges can always view clues
    can :read, Clue, :hunt => { :hunt_participants => { :user_id => user.id, :status => :judge } }

    # Participants can only view clues if hunt is live
    can :read, Clue, :hunt => { :hunt_participants => { :user_id => user.id }, :is_live => true }

    # Only participants can invite people to a hunt
    can :create, User, :hunt => { :hunt_participants => { :user_id => user.id } }

    # Only participants can view participants
    can :read, User, :hunt => { :hunt_participants => { :user_id => user.id } }

    # Only judges can manage judges
    can :update, HuntParticipant, :hunt => { :hunt_participants => { :user_id => user.id, :status => :judge } }

    # Judges can cancel any participant
    can :cancel, HuntInvitation, :hunt => { :hunt_participants => { :user_id => user.id, :status => :judge } }

    # The user who created the invitation can cancel it
    # can :cancel, HuntInvitation, :invited_by => user.id
  end
end
