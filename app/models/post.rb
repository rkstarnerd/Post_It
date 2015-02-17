class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_save :generate_slug

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

  def generate_slug
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug

    count = 2
    while post && post != self
      the_slug  = append_suffix(the_slug, count)
      post = Post.find_by slug: the_slug
      count += 1
    end

    self.slug = str.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s 
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip

    #replace non alphanumeric characters with a dash
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    #remove multiple, consecutive instances of a dash
    str.gsub! /-+/, "-"
    str
  end

  def to_param
    self.slug


  end
end