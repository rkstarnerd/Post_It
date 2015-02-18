
module Voteable
  extend AciveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

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