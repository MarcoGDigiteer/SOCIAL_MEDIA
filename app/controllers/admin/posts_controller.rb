class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:update, :toggle_visibility, :toggle_featured]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def update
    case params[:commit]
    when "Feature"
      toggle_featured
    when "Toggle Visibility"
      toggle_visibility
    end
  end

  def toggle_visibility
    @post.update_column(:visibility, !@post.visibility)
    redirect_back fallback_location: admin_dashboard_path, notice: "Visibility updated."
  end

  def toggle_featured
    if @post.featured?
      @post.update_column(:featured, false)
      redirect_back fallback_location: admin_dashboard_path, notice: "Post unfeatured."
    else
      if Post.where(featured: true).count < 5
        @post.update_column(:featured, true)
        redirect_back fallback_location: admin_dashboard_path, notice: "Post featured."
      else
        redirect_back fallback_location: admin_dashboard_path, alert: "Feature limit reached."
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
