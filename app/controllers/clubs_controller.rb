class ClubsController < ApplicationController
  before_filter :authenticate_user!

  before_filter :initialize_team

  def initialize_team
    @team = Team.new
  end

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find params[:id]
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

  def update
    session[:return_to] = request.referer
    @club_params = params[:club]
    @club = Club.find params[:id]
    if @club.officers.include? current_user
      @club.name = @club_params[:name]
      @club.description = @club_params[:description]

      unless @club.save
        flash[:error] = @team.errors.full_messages.to_sentence
      end
    else
      flash[:error] = "Only club officers can do that!"
    end

    redirect_to session.delete(:return_to)
  end

  def remove_user
    session[:return_to] = request.referer
    @club = Club.find(params[:club_id])
    if @club.officers.include? current_user
      @user = User.find(params[:user_id])
      @club.officers.remove @user
      @user.teams.each do |t|
        if t.club == self
          t.users.remove @user
          t.leaders.remove @user
        end
      end
    end
    redirect_to session.delete(:return_to)
  end

  def promote_user
    session[:return_to] = request.referer
    @club = Club.find(params[:club_id])
    if @club.officers.include? current_user
      @user = User.find(params[:user_id])
      @club.officers.append @user
    end
    redirect_to session.delete(:return_to)
  end

  def demote_user
    session[:return_to] = request.referer
    @club = Club.find(params[:club_id])
    if @club.presidents.include? current_user
      @user = User.find(params[:user_id])
      @club.officers.delete @user
    end
    redirect_to session.delete(:return_to)
  end

  def transfer_presidency
    session[:return_to] = request.referer
    @club = Club.find(params[:club_id])
    if @club.presidents.include? current_user
      @user = User.find(params[:user_id])
      @club.presidents.append @user
      @club.presidents.delete current_user
    end
    redirect_to session.delete(:return_to)
  end
end
