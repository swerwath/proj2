class Team < ActiveRecord::Base
  belongs_to :club
  has_many :announcements
  has_many :equipment
  has_and_belongs_to_many :users

  has_many :team_leaders
  has_many :leaders, :through => :team_leaders, :source => :user

  has_many :team_join_requests

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def feed(start_index=0, end_index=self.announcements.size)
    return self.announcements.reverse[start_index...end_index]
  end
end
