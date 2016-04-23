class Announcement < ActiveRecord::Base
  validates :title, presence: {message: " is missing. Every announcement needs a title."}

  belongs_to :team
  belongs_to :user
  has_many :comments

  # def email
  #    mg_client = Mailgun::Client.new "key-67de9679b4feb46d01e6f5cbc08f4b65"
  #    message_params =  { :from => 'postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org',
  #                         :to => "#{self.team.club}.#{self.team}@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org",
  #                         :subject => self.title,
  #                         :text => self.content}
  #    mg_client.send_message("sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org", message_params)
  # end

  # def email
  #   RestClient.post "https://api:key-67de9679b4feb46d01e6f5cbc08f4b65"\
  #   "@api.mailgun.net/v3/sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org/messages",
  #   :from => "Excited User <postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org>",
  #   :to => "#{self.team.club}.#{self.team}@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org, postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org",
  #   :subject => self.title,
  #   :text => self.content
  # end

  def email
    mg_client = Mailgun::Client.new "key-67de9679b4feb46d01e6f5cbc08f4b65"
    message_params =  { :from => 'postmaster@sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org',
                        :to => 'tom888cheng@gmail.com',
                        :subject => self.title,
                        :text => self.content}
    mg_client.send_message("sandbox83dd2cfc457e45fdbb7126e6893b8656.mailgun.org", message_params)
  end

end
