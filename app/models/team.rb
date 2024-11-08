class Team < ApplicationRecord
	belongs_to :owner, class_name: 'User'
	has_many :team_members
	has_many :members, through: :team_members, source: :user

	validates :name, :description, presence: { message: "%{attribute} can't be blank" }

end
