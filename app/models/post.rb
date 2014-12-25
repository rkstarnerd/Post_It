class Post < ActiveRecord::Base
  belongs_to :creater, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy
end