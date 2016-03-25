class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :teams

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def clubs:
    #TODO: Fill in this method, returns list of clubs the user is in
  end
end
