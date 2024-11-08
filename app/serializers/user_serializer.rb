# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role

  # Optionally include relationships if needed
  has_many :owned_teams, serializer: TeamSerializer
end
