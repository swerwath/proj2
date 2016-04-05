class Club < ActiveRecord::Base
  has_many :teams

  def officers
    officers = []
    self.teams.each do |t|
      officers.append t.leader
    end
    return officers
  end

  def feed
    club_feed = []
    current_user.teams.each do |t|
      if t.club == self
        club_feed.append t.feed
      end
    end
    sorted_feed = club_feed.sort_by do |announcement|
      announcement.created_at
    end
    sorted_feed.reverse
  end

end
