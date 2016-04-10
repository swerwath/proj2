class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :team_leaders
  has_many :led_teams, :through => :team_leaders, :source => :team

  has_many :club_officers
  has_many :officerships, :through => :club_officers, :source => :club

  has_many :club_presidents
  has_many :presidentships, :through => :club_presidents, :source => :club

  has_and_belongs_to_many :teams
  has_many :comments
  has_many :announcements

  has_many :team_join_requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

  def club_feed(club_id)
    club = Club.find(club_id)
    club_feed = []

    club.teams.each do |t|
      if t.club == club
        club_feed.concat t.feed
      end
    end

    sorted_feed = club_feed.sort_by do |announcement|
      announcement.created_at
    end

    sorted_feed.reverse
  end

  def feed
    raw_feed = []

    self.clubs.each do |c|
      raw_feed.concat self.club_feed (c.id)
    end

    sorted_feed = raw_feed.sort_by do |announcement|
      announcement.created_at
    end

    sorted_feed.reverse
  end

end
