class ClubsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :initialize_team

  def initialize_team
    @team = Team.new
  end

  def create
      @club = Club.new
      @club.name = params[:club][:name]
      @club.description = params[:club][:description]
      @club.closed = params[:club][:closed]
      @club.officers.append(current_user)
      @club.presidents.append(current_user)
      if @club.save
        @genTeam = Team.new name: "general", description: "General Discussion", closed: false, club_id: @club.id
        @genTeam.leaders.append(current_user)
        @genTeam.users.append(current_user)
        @genTeam.save
        create_club_mailing_list(@club.name)
        redirect_to @club
      else
        flash[:error] = @club.errors.full_messages.to_sentence
        redirect_to new_team_path
      end
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

      addToGeneralMailingList(club)

      join_announcement = Announcement.create(team_id: general_team.id, user_id: current_user.id, title: announce_title)

      # join_announcement.email(join_announcement)

      redirect_to "/clubs/#{club.id}"
    else
      redirect_to root_path
    end
  end

  def addToGeneralMailingList(club)
      hello = RestClient.post("https://api:key-67de9679b4feb46d01e6f5cbc08f4b65" \
                "@api.mailgun.net/v3/lists/#{club.name}.general@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org/members",
                :subscribed => true,
                :address => current_user.email,
                :name => current_user.name)
      puts hello
  end

  def create_club_mailing_list(clubName)
      response = RestClient.post("https://api:key-67de9679b4feb46d01e6f5cbc08f4b65" \
                  "@api.mailgun.net/v3/lists",
                  :address => "#{clubName}.general@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org",
                  :description => "General Mailing List for #{clubName}")
      puts response
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
