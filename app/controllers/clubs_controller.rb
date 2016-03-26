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
      general_team = Team.where(club_id: club.id, name: "general")
      current_user.teams.append(general_team)
      redirect_to "/clubs/#{club.id}"
    else
      redirect_to root_path
    end
  end
end
