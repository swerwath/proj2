class TeamJoinRequestsController < ApplicationController
  def create
    TeamJoinRequest.create user_id: current_user.id, team_id: params[:id]
    redirect_to root
  end
end
