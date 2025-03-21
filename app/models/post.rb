class Post < ApplicationRecord
  before_create :set_created_date
  before_update :set_edited_date

  has_many :post_likes, dependent: :destroy
  has_many :liked_users, through: :post_likes, source: :user
  has_many :comments, dependent: :destroy

  validates :title, presence: { message: "Title cannot be blank" }, 
                    uniqueness: { message: "Title must be unique" }, 
                    length: { maximum: 255, message: "Title cannot exceed 255 characters" }
                    
  validates :body, presence: { message: "Content cannot be blank" }, 
                   length: { maximum: 1500, message: "Content cannot exceed 1500 characters" }

  def liked_users
    post_likes.includes(:user).map(&:user)
  end
  private
  def set_created_date
    self.date_created = Time.current
  end

  def set_edited_date
    self.date_edited = Time.current
  end
end