class AnnouncementsController < ApplicationController
  def create
    session[:return_to] = request.referer
    @a = Announcement.new user_id: current_user.id, team_id: params[:announcement][:team_id],
                            title: params[:announcement][:title], content: params[:announcement][:content],
                            email_blast: params[:announcement][:email_blast]
    if @a.save
      if @a.email_blast
        # RestClient.post "https://api:key-67de9679b4feb46d01e6f5cbc08f4b65"\
        # "@api.mailgun.net/v3/sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org/messages",
        # :from => "postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org",
        # :to => "#{@a.team.club}.#{@a.team}@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org, postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org",
        # :subject => @a.title,
        # :text => @a.content
        @a.email
      end
    else
      flash[:error] = @a.errors.full_messages.to_sentence
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    a = Announcement.find(params[:id])

    # How to get the contents of the announcement and email it to the users?
    # announcementText = @a.
    mg_client = Mailgun::Client.new "key-67de9679b4feb46d01e6f5cbc08f4b65"
    message_params =  { :from => 'postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org',
                        :to => 'tom888cheng@gmail.com',
                        :subject => 'An announcement was just deleted.',
                        :text => 'accouncementText'}
    mg_client.send_message("sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org", message_params)

    if a.user == current_user
      a.delete
    end

    redirect_to session.delete(:return_to)
  end


  def email(announcement)
     console.log("I am being called from emil ")
     mg_client1 = Mailgun::Client.new "key-67de9679b4feb46d01e6f5cbc08f4b65"
      message_params =  { :from => 'postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org',
                          :to => 'tom888cheng@gmail.com',
                          :subject => 'Created.',
                          :text => 'adfadfafafas'}
     mg_client1.send_message("sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org", message_params)
  end
end
