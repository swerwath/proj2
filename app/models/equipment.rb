class Equipment < ActiveRecord::Base
  validates :name, presence: {message: " is missing. Equipment needs a name."}
  validates :condition, presence: {message: " is missing. Equipment needs a condition."}

  belongs_to :user
  belongs_to :team

  def checked_out?
    not self.user.nil?
  end

  def create
  end

end
