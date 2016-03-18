class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  has_and_belongs_to_many :users
end
