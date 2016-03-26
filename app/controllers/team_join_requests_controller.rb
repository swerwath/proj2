class TeamJoinRequestsController < ApplicationController
  def create
    TeamJoinRequest.create user_id: current_user.id, team_id: params[:id]
    redirect_to root
  end

  def approve
    request = TeamJoinRequest.find(params[:id])
    user = request.user
    team_to_join = request.team
    user.teams.append(team_to_join)
    request.destroy
  end

  def destroy
    request = TeamJoinRequest.find(params[:id])
    request.destroy
  end

end
