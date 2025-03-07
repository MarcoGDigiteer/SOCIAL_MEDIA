class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)  # Fetch all posts from the database
  end
end
