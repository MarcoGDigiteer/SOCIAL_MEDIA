class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :post_likes, dependent: :destroy
  has_many :liked_posts, through: :post_likes, source: :post
end
