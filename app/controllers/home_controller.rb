class HomeController < ApplicationController
  def index
    # If we aren't signed in, redirect to our sign in page
    if not user_signed_in?
      redirect_to new_user_session_path
    end

  end
end
