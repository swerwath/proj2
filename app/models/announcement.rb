class Announcement < ActiveRecord::Base
  validates :title, presence: {message: " is missing. Every announcement needs a title."}

  belongs_to :team
  belongs_to :user
  has_many :comments
end
