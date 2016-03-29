class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :teams
  has_many :comments
  has_many :announcements

  has_many :team_join_requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def teams_led
    return Team.where(leader_id: self.id).all
  end

  def is_in_club?(c)
    return self.clubs.include? c
  end

  def clubs
    c = Array.new
    self.teams.each do |t|
      if t.name == "general"
        c.append(t.club)
      end
    end
    return c
  end
end
