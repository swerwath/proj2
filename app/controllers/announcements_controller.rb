class AnnouncementsController < ApplicationController
  def create
    session[:return_to] = request.referer
    @a = Announcement.new user_id: current_user.id, team_id: params[:announcement][:team_id],
                            title: params[:announcement][:title], content: params[:announcement][:content],
                            email_blast: params[:announcement][:email_blast]

    if @a.save
      if @a.email_blast
        #TODO: add email functionality
      end
    else
      flash[:error] = @a.errors.full_messages.to_sentence
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    a = Announcement.find(params[:id])
    if a.user == current_user
      a.delete
    end
    redirect_to session.delete(:return_to)
  end
end
