class PostLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    post_like = @post.post_likes.build(user: current_user)

    if post_like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_path, notice: "Post liked!" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_like = @post.post_likes.find_by(user: current_user)
    post_like&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: "Post unliked!" }
    end
  end
end
