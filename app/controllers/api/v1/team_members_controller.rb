class Api::V1::TeamMembersController < Api::V1::BaseController
  before_action :set_team
  before_action :authorize_owner, only: [:create, :destroy]
  before_action :set_member, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  # GET /api/v1/teams/:team_id/team_members
  def index
    members = @team.members
    members = members.where("last_name ILIKE ?", "%#{params[:last_name]}%") if params[:last_name].present?
    render json: members, status: :ok
  end

  # POST /api/v1/teams/:team_id/team_members
  def create
    user = User.find_by(email: params[:email])
    if user && !@team.members.include?(user)
      @team.members << user
      render json: { message: "Member added successfully" }, status: :created
    else
      render json: { error: "User not found or already a member" }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/teams/:team_id/team_members/:id
  def show
    render json: @member, status: :ok
  end

  # DELETE /api/v1/teams/:team_id/team_members/:id
  def destroy
	  @member = @team.members.find_by(id: params[:id]) # Ensure @member is set correctly.

	  if @member && @team.members.delete(@member)
	    render json: { message: "Member removed successfully" }, status: :ok
	  else
	    render json: { error: "Failed to remove member" }, status: :unprocessable_entity
	  end
	end


  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_member
    @member = @team.members.find_by(id: params[:id])
    if @member.nil?
      render json: { error: 'Team member not found' }, status: :not_found

    end
  end

  def authorize_owner
    render json: { error: 'Not authorized' }, status: :forbidden unless @team.owner == current_user
  end
end
