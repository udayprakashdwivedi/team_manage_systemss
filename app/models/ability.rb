# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.owner?
      can :manage, Team, owner_id: user.id
      can :manage, TeamMember, team: { owner_id: user.id }
    # Define permissions for members
    elsif user.member?
      can :read, Team
      can :read, TeamMember
    end
  end
end
