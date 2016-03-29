class TeamJoinRequestsController < ApplicationController
  def create
    session[:return_to] = request.referer
    TeamJoinRequest.create user_id: current_user.id, team_id: params[:id]
    redirect_to session.delete(:return_to)
  end

  def approve
    request = TeamJoinRequest.find(params[:id])
    user = request.user
    team_to_join = request.team
    user.teams.append(team_to_join)
    announce_title = user.name+" has joined "+team_to_join.club.name+"#"+team_to_join.name
    join_announcement = Announcement.create(team_id: team_to_join.id, user_id: user.id, title: announce_title)
    request.destroy
  end

  def destroy
    session[:return_to] = request.referer
    request = TeamJoinRequest.find(params[:id])
    request.destroy
    redirect_to session.delete(:return_to)
  end

end
