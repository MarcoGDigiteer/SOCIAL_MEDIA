class PagesController < ApplicationController
  def home
    @posts = Post.order(created_at: :desc)
  end
  def featured
    @posts = Post.order(created_at: :desc).limit(5)  
  end
  def create
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      head :no_content
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end  
end
