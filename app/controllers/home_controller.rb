class HomeController < ApplicationController
  def index
    if admin_signed_in?
      sort_param = params[:sort] || "newest"
      user_filter = params[:user]

      @posts = Post.all
      @posts = @posts.where(email: user_filter) if user_filter.present?

      @posts = case sort_param
               when "oldest"
                 @posts.order(created_at: :asc)
               when "title_asc"
                 @posts.order(title: :asc)
               when "title_desc"
                 @posts.order(title: :desc)
               else
                 @posts.order(created_at: :desc)
               end

      @users = Post.select(:email).distinct.pluck(:email)

      respond_to do |format|
        format.html
        format.turbo_stream { render turbo_stream: turbo_stream.replace("posts_list", partial: "posts/list", locals: { posts: @posts }) }
      end
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end
end