class HomeController < ApplicationController
  def index
    # If we aren't signed in, redirect to our sign in page
    if not user_signed_in?
      redirect_to landing_path
    end

  end
end
