class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  def create
    post = Post.new(post_params)

    if post.save
      render json: { success: true, post: post }, status: :created
    else
      render json: { success: false, errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: { success: true, post: @post }, status: :ok
    else
      render json: { success: false, errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

  