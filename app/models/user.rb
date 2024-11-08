class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_teams, class_name: 'Team', foreign_key: :owner_id
  has_many :team_memberships, class_name: 'TeamMember'
  has_many :teams, through: :team_memberships

  enum role: { member: 0, owner: 1 }

  validates :email, :password, presence: { message: "%{attribute} can't be blank" }


  def create_new_jwt_token
    payload = { user_id: self.id, exp: (Time.now + 2.weeks).to_i }
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key, 'HS256')
  end
end
