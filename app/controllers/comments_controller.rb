class CommentsController < ApplicationController
  def create
    session[:return_to] = request.referer
    c = Comment.create user_id: current_user.id, announcement_id: params[:comment][:announcement_id], content: params[:comment][:content]
    redirect_to session.delete(:return_to)
  end
end
