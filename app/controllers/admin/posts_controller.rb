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
    @post.update(visibility: !@post.visibility)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: admin_dashboard_path, notice: "Visibility updated." }
    end
  end
  

  def toggle_featured
    if @post.featured?
      @post.update(featured: false)
    else
      if Post.where(featured: true).count < 5
        @post.update(featured: true)
      else
        respond_to do |format|
          format.html { redirect_back fallback_location: admin_dashboard_path, alert: "Feature limit reached." }
        end
        return
      end
    end
  
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: admin_dashboard_path, notice: "Post updated." }
    end
  end
  

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
