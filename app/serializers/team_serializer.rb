# app/serializers/team_serializer.rb
class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at

  # Include owner details
  belongs_to :owner, serializer: UserSerializer

  # Optionally, include team members
  has_many :members, serializer: UserSerializer
end
