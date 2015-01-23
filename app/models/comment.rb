class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true
  validates :user_id, presence: true

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote:false).size
  end

  def total_votes
    (up_votes - down_votes)
  end
end