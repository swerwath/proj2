class Comment < ActiveRecord::Base
    validates :content, presence: {message: " is required for every comment."}

    belongs_to :user
    belongs_to :announcement
end
