# app/controllers/api/v1/teams_controller.rb
class Api::V1::TeamsController < Api::V1::BaseController
  before_action :set_team, only: [:show, :update, :destroy]
  before_action :authorize_owner, only: [:update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /api/v1/teams
  def index
    teams = current_user.owned_teams
    # render json: teams, status: :ok
    success('Teams fetched successfully.', ActiveModelSerializers::SerializableResource.new(teams, each_serializer: TeamSerializer))

  end

  # POST /api/v1/teams
  def create
    team = current_user.owned_teams.new(team_params)
    if team.save
      render json: { team: team }, status: :created
    else
      render json: { errors: team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/teams/:id
  def show
    success('Team fetched successfully.', ActiveModelSerializers::SerializableResource.new(@team, serializer: TeamSerializer))
  end

  # PATCH/PUT /api/v1/teams/:id
  def update
    if @team.update(team_params)
      render json: { team: @team }, status: :ok
    else
      render json: { errors: @team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/teams/:id
  def destroy
    @team.destroy
    render json: { message: 'Team deleted successfully' }, status: :ok
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description)
  end

  def authorize_owner
    render json: { error: 'Not authorized' }, status: :forbidden unless @team.owner == current_user
  end
end
