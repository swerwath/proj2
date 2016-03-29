class ClubsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
  end

  def join
    club = Club.find(params[:id])
    if not club.closed
      general_team = Team.where(club_id: club.id, name: "general").first
      current_user.teams.append(general_team)
      announce_title = current_user.name+" has joined "+club.name+".general"
      join_announcement = Announcement.create(team_id: general_team.id, user_id: current_user.id, title: announce_title)
      redirect_to "/clubs/#{club.id}"
    else
      redirect_to root_path
    end
  end
end
