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
    return []
  end
  
end
