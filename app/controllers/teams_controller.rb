class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])

    # We can't join the team without first being in the club
    if !current_user.clubs.include? @team.club
      redirect_to @team.club
    end
  end

  def join
    team = Team.find(params[:id])
    if not team.closed and current_user.clubs.include? team.club
      current_user.teams.append(team)
      announce_title = current_user.name+" has joined "+team.club.name+"."+team.name
      join_announcement = Announcement.create(team_id: team.id, user_id: current_user.id, email_blast: false, title: announce_title)
    end
    redirect_to "/teams/#{team.id}"
  end

end
