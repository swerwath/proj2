class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :initialize_comment
  before_filter :initialize_announcement

  def initialize_comment
    @comment = Comment.new
  end
  def initialize_announcement
    @announcement = Announcement.new
  end


  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up)        << :name
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
