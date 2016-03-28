class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  has_many :announcements
  has_and_belongs_to_many :users

  has_many :team_join_requests

  def feed(start=0, end=self.announcements.size)
    self.announcements[start...end]
  end
end
