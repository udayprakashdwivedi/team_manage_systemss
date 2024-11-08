# app/serializers/team_member_serializer.rb
class TeamMemberSerializer < ActiveModel::Serializer
  attributes :id, :role

  # Include the associated team and user details
  belongs_to :user, serializer: UserSerializer
  belongs_to :team, serializer: TeamSerializer
end
