class Club < ActiveRecord::Base
  has_many :teams
  has_many :club_officers
  has_many :officers, :through => :club_officers, :source => :user
end
