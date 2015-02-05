class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 3}
  validates :description, presence: true

  def up_votes
    self.votes.where(vote: true).size  
  end

  def down_votes
    self.votes.where(vote:false).size
  end

  def total_votes
    up_votes - down_votes
  end

  def to_param
    self.slug
  end
end