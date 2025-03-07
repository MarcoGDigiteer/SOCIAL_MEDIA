class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :my_posts]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    if admin_signed_in?
      @posts = Post.all # Admins see all posts
    else
      @posts = Post.where(visibility: true).order(created_at: :desc) # Normal users see only visible posts
    end
  end
  

  def featured
    @posts = Post.where(featured: true, visibility: true).order(created_at: :desc) # Ensure only visible featured posts
  end

  def my_posts
    @posts = Post.where(email: current_user.email).order(created_at: :desc) # Fetch only current user's posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.email = current_user.email
    @post.featured = false
    @post.visibility = true
  
    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post updated successfully."
    else
      render :edit
    end
  end
  

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to posts_path, alert: "Not authorized." unless @post.email == current_user.email
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
