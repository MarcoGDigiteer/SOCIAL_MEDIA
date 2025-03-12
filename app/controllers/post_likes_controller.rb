class PostLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    post_like = post.post_likes.build(user: current_user)

    if post_like.save
      redirect_to posts_path, notice: "Post liked!"
    else
      redirect_to posts_path, alert: "You have already liked this post."
    end
  end

  def destroy
    post_like = PostLike.find_by(post_id: params[:post_id], user_id: current_user.id)
    post_like.destroy if post_like
    redirect_to posts_path, notice: "Post unliked!"
  end
end
