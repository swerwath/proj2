class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  has_many :announcements
  has_and_belongs_to_many :users

  has_many :team_join_requests

  def feed(start_index=0, end_index=self.announcements.size)
    return self.announcements[start_index...end_index]
  end
end
