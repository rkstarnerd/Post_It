class Post < ActiveRecord::Base

  include VoteableGemille

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories

  before_save :generate_slug

  validates :title, presence: true, length: {minimum: 3}
  validates :description, presence: true

  def to_param
    self.slug
  end

  def to_slug(name)
    str = name.strip

    #replace non alphanumeric characters with a dash
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    #remove multiple, consecutive instances of a dash
    str.gsub! /-+/, "-"
    str.downcase
  end

  def generate_slug
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug

    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end
end