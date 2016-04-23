class TeamsController < ApplicationController
  before_filter :initialize_equipment

  def initialize_equipment
    @equipment = Equipment.new
  end

  def destroy
    session[:return_to] = request.referer
    @team = Team.find params[:id]
    if @team.club.presidents.include? current_user
      @team.delete
    else
      flash[:error] = "Only club presidents can do that!"
    end
    redirect_to session.delete(:return_to)
  end

  def show
    @team = Team.find(params[:id])

    # We can't join the team without first being in the club
    if !current_user.clubs.include? @team.club
      redirect_to @team.club
    end
  end

  def update
    session[:return_to] = request.referer
    @team_params = params[:team]
    @team = Team.find params[:id]
    if @team.leaders.include? current_user
      @team.name = @team_params[:name]
      @team.description = @team_params[:description]

      unless @team.save
        flash[:error] = @team.errors.full_messages.to_sentence
      end
    else
      flash[:error] = "Only team leaders can do that!"
    end

    redirect_to session.delete(:return_to)
  end

  def remove_user
    session[:return_to] = request.referer
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @team.users.delete(@user)
    redirect_to session.delete(:return_to)
  end

  def promote_user
    session[:return_to] = request.referer
    @team = Team.find(params[:team_id])
    if @team.leaders.include? current_user
      @user = User.find(params[:user_id])
      @team.leaders.append @user
    end
    redirect_to session.delete(:return_to)
  end

  def add_user_to_team
    session[:return_to] = request.referer
    @team = Team.find(params[:team_id])
    if @team.leaders.include? current_user
      @user = User.find(params[:user_id])
      @team.users.append @user
    end
    redirect_to session.delete(:return_to)
  end

  def new
    @team = Team.new
    @club_id = params[:club_id]
  end

  def create
    @team = Team.new
    @team.name = params[:team][:name]
    @team.description = params[:team][:description]
    @team.closed = params[:team][:closed]
    @team.club = Club.find(params[:team][:club_id])
    @team.leaders.append(current_user)
    @team.users.append(current_user)
    if @team.save
      create_title = current_user.name+" created "+@team.club.name+"."+@team.name
      create_announcement = Announcement.create team_id: @team.id, user_id: current_user.id, email_blast: false, title: create_title
      redirect_to @team
    else
      flash[:error] = @team.errors.full_messages.to_sentence
      redirect_to new_team_path
    end
  end

  def join
    @team = Team.find(params[:id])
    if not @team.closed and current_user.clubs.include? @team.club
      current_user.teams.append(@team)
      announce_title = current_user.name+" has joined "+@team.club.name+"."+@team.name
      join_announcement = Announcement.create team_id: @team.id, user_id: current_user.id, email_blast: false, title: announce_title

      # Comment if want.
      # join_announcement.email
    end
    redirect_to "/teams/#{@team.id}"
  end

end
