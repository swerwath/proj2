class CommentsController < ApplicationController
  def create
    session[:return_to] = request.referer
    @c = Comment.new user_id: current_user.id, announcement_id: params[:comment][:announcement_id], content: params[:comment][:content]
    if not @c.save
        flash[:error] = @c.errors.full_messages.to_sentence        
    end
    redirect_to session.delete(:return_to)
  end
end
