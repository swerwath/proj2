class Club < ActiveRecord::Base
  has_many :teams
  has_many :club_officers
  has_many :club_presidents
  has_many :officers, :through => :club_officers, :source => :user
  has_many :presidents, :through => :club_presidents, :source => :user

  def members
    members = []
    self.teams.each do |t|
      members += t.users
    end
    members.uniq
  end

end
