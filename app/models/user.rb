class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  before_save :generate_slug

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug

    count = 2
    while user && user != self
      the_slug = append_suffix(the_slug, count)
      user = User.find_by slug: the_slug
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
    str.downcase
  end
end