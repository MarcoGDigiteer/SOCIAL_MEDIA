class CommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!, only: [:new, :create]
  
    def index
      @comments = @post.comments.order(created_at: :desc)
    end
  
    def new
      @comment = @post.comments.build
    end
  
    def create
      @comment = @post.comments.build(comment_params)
      @comment.email = current_user.email
  
      if @comment.save
        redirect_to post_comments_path(@post), notice: "Comment posted successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  