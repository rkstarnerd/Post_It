class User < ActiveRecord::Base
  has_many :posts, :comments, dependent: :destroy
end